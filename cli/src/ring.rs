// This module implements a SPSC Ring Buffer between two threads
use std::cell::SyncUnsafeCell;
use std::sync::Arc;
use std::sync::atomic::Ordering::{Acquire, Release};
use std::sync::atomic::AtomicUsize;
use std::result::Result;
use std::slice::{from_raw_parts_mut, from_raw_parts};
use std::clone::Clone;

pub struct Ringbuffer<T: Default + Clone, const N: usize> {
    raw: SyncUnsafeCell<Box<[T]>>,
    pushed: AtomicUsize,
    pulled: AtomicUsize,
}

impl<T: Default + Clone, const N: usize> Ringbuffer<T, N> {
    pub fn new() -> Arc<Self> {
        Arc::new(Self {
            raw: SyncUnsafeCell::new(vec![T::default(); N].into_boxed_slice()),
            pushed: AtomicUsize::new(0),
            pulled: AtomicUsize::new(0),
        })
    }
    pub fn split(self: Arc<Self>) -> (Writer<T, N>, Reader<T, N>) {(
        Writer {buf: self.clone(), alloc: self.pushed.load(Acquire)},
        Reader {buf: self.clone(), alloc: self.pulled.load(Acquire)}
    )}
}

pub struct Writer<T: Default + Clone, const N: usize> {
    buf: Arc<Ringbuffer<T, N>>,
    alloc: usize,
}

impl<T: Default + Clone, const N: usize> Writer<T, N> {
    pub fn free(&self) -> usize {
        let pulled = self.buf.pulled.load(Acquire);
        if self.alloc >= pulled {
            N - (self.alloc - pulled) - 1
        } else {
            pulled - self.alloc -1
        }
    }

    pub fn write<F>(&mut self, size: usize, f: F) -> Result<(), Error>
        where F: FnOnce(&mut[T], &mut[T]) {
        // (1) Remaining capacity in ring buffer
        let pulled = self.buf.pulled.load(Acquire);

        let (cap_back, cap_front) = if self.alloc > pulled {
            (N - self.alloc, pulled - 1) // write ptr >= read ptr
        } else if self.alloc < pulled {
            (pulled - self.alloc - 1, 0) // write ptr < read ptr
        } else {
            if self.alloc > 0 {
                (N - self.alloc, self.alloc - 1)
            } else {
                (N - self.alloc - 1, 0)
            }
        };

        let free = cap_back + cap_front;
        if free < size {
            return Err(Error::Full(N, free));
        }

        let alloc_back = std::cmp::min(size, cap_back);
        let alloc_front = size - alloc_back;
        assert!((alloc_back + alloc_front) == size);

        // (3) Apply write buffers
        let (back, front) = unsafe {
            let raw = self.buf.raw.get();
        	(from_raw_parts_mut(&mut(*raw)[self.alloc], alloc_back),
            from_raw_parts_mut(&mut(*raw)[0], alloc_front))
        };
        f(back, front);

        // (4) Update thread-local allocation + stat
        self.alloc = (self.alloc + size) % N;

        Ok(())
    }

    pub fn commit(&self) {
        self.buf.pushed.store(self.alloc, Release);
    }
}

pub struct Reader<T: Default + Clone, const N: usize> {
    buf: Arc<Ringbuffer<T, N>>,
    alloc: usize,
}

impl<T: Default + Clone, const N: usize> Reader<T, N> {
    pub fn read<F>(&mut self, f: F) -> Result<(), Error>
        where F: FnOnce(&[T], &[T]) {
        // (1) Check available capacity in ring buffer
        let pushed = self.buf.pushed.load(Acquire);
        let (cap_back, cap_front) = if pushed < self.alloc {
            (N - self.alloc, pushed)
        } else if pushed > self.alloc {
            (pushed - self.alloc, 0)
        } else {
            return Err(Error::Empty);
        };

        // (2) Apply read buffers
        let (back, front) = unsafe {
            let raw = self.buf.raw.get();
            (from_raw_parts(&(*raw)[self.alloc], cap_back),
            from_raw_parts(&(*raw)[0], cap_front))
        };
        f(back, front);

        // (3) Update thread-local allocation
        self.alloc = pushed;

        Ok(())
    }

    pub fn commit(&self) {
        self.buf.pulled.store(self.alloc, Release);
    }
}

#[derive(Debug)]
pub enum Error {
    Empty,
    Full(usize, usize),
}

impl std::fmt::Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Error::Empty => write!(f, "Buffer is empty"),
            Error::Full(s, a) => write!(f, "Buffer of {} only has {} available", s, a),
        }
    }
}

impl std::error::Error for Error {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        match self {
            Error::Full(_, _) => None,
            Error::Empty => None,
        }
    }
}
