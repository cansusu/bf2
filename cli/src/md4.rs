// This module implements SIMD-accelerated multi-message MD4 hashing
// for ASCII passwords that fit into a single MD4 digest block
use std::simd::{Simd, LaneCount, SupportedLaneCount};
use std::ops::{Shl, Shr};
use std::simd::num::SimdUint;
use std::simd::num::SimdInt;

const BLOCK_SIZE: usize = 16;

pub struct SimdHasher<const LANES: usize, const TRAIL_LEN: usize> {
pattern: [u32; BLOCK_SIZE],
msgs: [[u32; LANES]; BLOCK_SIZE],
pos: usize,
}

pub type Digest<const LANES: usize> = (
Simd<i32, LANES>, Simd<i32, LANES>, Simd<i32, LANES>, Simd<i32, LANES>
);

impl<const LANES: usize, const TRAIL_LEN: usize> SimdHasher<LANES, TRAIL_LEN>
where LaneCount<LANES>: SupportedLaneCount {
#[inline]
fn init_pattern(&mut self) {
	// (1b) Set trailing bit
	if TRAIL_LEN % 2 == 0 {
		self.pattern[TRAIL_LEN / 2] = 0x80u32 << 16;
	} else {
	self.pattern[((TRAIL_LEN - 1) / 2) + 1] = 0x00u32 | 0x80u32;
	}

	// (1c) Write length in bits
	self.pattern[14] = u32::try_from((TRAIL_LEN + 1) * 16)
	.expect("Cannot convert usize to u32");
}



#[inline]
fn gen_pattern(&mut self, pw: [u8; TRAIL_LEN]) {
	self.pattern[0] = (pw[0] as u32) << 16;
	for i in 1..(TRAIL_LEN / 2) {
		self.pattern[i] = ((pw[i * 2] as u32) << 16) | (pw[(i * 2) - 1] as u32);
	}
	if (TRAIL_LEN % 2) == 1 {
		let part_pos = (TRAIL_LEN - 1)/ 2;
		self.pattern[part_pos] = ((pw[part_pos * 2] as u32) << 16) | (pw[(part_pos * 2) - 1] as u32);
	}
	if (TRAIL_LEN % 2) == 0 {
		let part_pos = TRAIL_LEN / 2;
		self.pattern[part_pos] = (self.pattern[part_pos] & 0xffff0000) | (pw[TRAIL_LEN - 1] as u32);
	}

}
#[inline]
fn broadcast_pattern(&mut self, start: usize, end: usize) {
for j in 0..BLOCK_SIZE {
self.msgs[j][start..end].fill(self.pattern[j]);
}
}

#[inline]
fn set_pattern(&mut self, bmask: u32, prefix: u8, start: usize, end: usize) -> u32 {
let mut bmask = bmask;
for i in start..end {
if bmask == 0 { // No further matches
unreachable!();
}

let t = bmask & ((-(bmask as i32)) as u32);
let prefix_byte: u8 = prefix | (t.trailing_zeros() as u8);
self.msgs[0][i] = (self.msgs[0][i] & 0xffff0000) | (prefix_byte as u32);
bmask = bmask ^ t;
}
return bmask;
}

const fn check_valid_len(len: usize) {
assert!((len + 1) <= 27, "total length must be less than 27 to fit into an MD4 block");
}

pub fn submit<F>(&mut self, mask: u32, prefix: u8, pw: [u8; TRAIL_LEN], mut f: F)
where F: FnMut([u32; 4]) {
Self::check_valid_len(TRAIL_LEN);
let mut bmask: u32 = mask;
let total: usize = mask.count_ones().try_into()
.expect("Cannot convert u32 to usize");


//(1) Prepare message layout for broadcast
self.gen_pattern(pw);

// (2) Process remaining slots
let lead = std::cmp::min(LANES - self.pos, total);
if lead > 0 {
// (2a) Broadcast pattern into remaining slots
let start = self.pos;
let end = self.pos + lead;
self.broadcast_pattern(start, end);

// (2b) Handle remaining slots
bmask = self.set_pattern(bmask, prefix, start, end);

if end < LANES {
self.pos = end;
return;
}
}
Self::digest(&self.msgs, &mut f);

// (3) Process full chunks
let remaining = total - lead;
if remaining > 0 {
// (3a) Broadcast pattern into previously used slots
self.broadcast_pattern(0, std::cmp::min(LANES, remaining));
}
let chunks = remaining / LANES;
let follow = remaining % LANES;

// (3b) Handle full slots
for _ in 0..chunks {
bmask = self.set_pattern(bmask, prefix, 0, LANES);
Self::digest(&self.msgs, &mut f);
}

// (4) Populate next slots
if follow > 0 {
bmask = self.set_pattern(bmask, prefix, 0, follow);
assert!(bmask == 0);
}
self.pos = follow;
}

pub fn flush<F>(&mut self, mut f: F) where F: FnMut([u32; 4]) {
Self::digest(&self.msgs, &mut f);
}

/// MD4 transformation F for the first round
#[inline]
fn md4_func_f<const S: u32>(a: &mut Simd<i32, LANES>, b: &Simd<i32, LANES>,
   c: &Simd<i32, LANES>, d: &Simd<i32, LANES>, x: &Simd<i32, LANES>) {
   let t: Simd<u32, LANES> = ((*a + x) + (d ^ (b & (c ^ d)))).cast();
   *a = (t << S | (t >> (32-S))).cast();
}

/// MD4 transformation G for the second round
#[inline]
fn md4_func_g<const S: u32>(a: &mut Simd<i32, LANES>, b: &Simd<i32, LANES>,
   c: &Simd<i32, LANES>, d: &Simd<i32, LANES>, x: &Simd<i32, LANES>) {
   let imm: Simd<i32, LANES> = Simd::<i32, LANES>::splat(0x5a827999u32 as i32);
   let t: Simd<u32, LANES> = (((*a + *x) + imm) + ((*b & (*c | *d)) | (*c & *d))).cast();
   *a = (t.shl(S) | (t.shr(32-S))).cast();
}

/// MD4 transformation H for the third round
#[inline]
fn md4_func_h<const S: u32>(a: &mut Simd<i32, LANES>, b: &Simd<i32, LANES>,
   c: &Simd<i32, LANES>, d: &Simd<i32, LANES>, x: &Simd<i32, LANES>) {
   let imm: Simd<i32, LANES> = Simd::<i32, LANES>::splat(0x6ed9eba1u32 as i32);
   let t: Simd<u32, LANES> = (((*a + *x) + imm) + ((*b ^ *c) ^ *d)).cast();
   *a = (t.shl(S) | (t.shr(32-S))).cast();
}

#[inline]
pub fn iter(msg: [Simd<i32, LANES>; BLOCK_SIZE]) -> Digest<LANES> {
let mut a = Simd::<i32, LANES>::splat(0x67452301u32 as i32);
let mut b = Simd::<i32, LANES>::splat(0xefcdab89u32 as i32);
let mut c = Simd::<i32, LANES>::splat(0x98badcfeu32 as i32);
let mut d = Simd::<i32, LANES>::splat(0x10325476u32 as i32);

   // First Round
   Self::md4_func_f::< 3>(&mut a, &b, &c, &d, &msg[0]);
   Self::md4_func_f::< 7>(&mut d, &a, &b, &c, &msg[1]);
   Self::md4_func_f::<11>(&mut c, &d, &a, &b, &msg[2]);
   Self::md4_func_f::<19>(&mut b, &c, &d, &a, &msg[3]);

   Self::md4_func_f::< 3>(&mut a, &b, &c, &d, &msg[4]);
   Self::md4_func_f::< 7>(&mut d, &a, &b, &c, &msg[5]);
   Self::md4_func_f::<11>(&mut c, &d, &a, &b, &msg[6]);
   Self::md4_func_f::<19>(&mut b, &c, &d, &a, &msg[7]);

   Self::md4_func_f::< 3>(&mut a, &b, &c, &d, &msg[8]);
   Self::md4_func_f::< 7>(&mut d, &a, &b, &c, &msg[9]);
   Self::md4_func_f::<11>(&mut c, &d, &a, &b, &msg[10]);
   Self::md4_func_f::<19>(&mut b, &c, &d, &a, &msg[11]);

   Self::md4_func_f::< 3>(&mut a, &b, &c, &d, &msg[12]);
   Self::md4_func_f::< 7>(&mut d, &a, &b, &c, &msg[13]);
   Self::md4_func_f::<11>(&mut c, &d, &a, &b, &msg[14]);
   Self::md4_func_f::<19>(&mut b, &c, &d, &a, &msg[15]);

   // Second Round
   Self::md4_func_g::< 3>(&mut a, &b, &c, &d, &msg[0]);
   Self::md4_func_g::< 5>(&mut d, &a, &b, &c, &msg[4]);
   Self::md4_func_g::< 9>(&mut c, &d, &a, &b, &msg[8]);
   Self::md4_func_g::<13>(&mut b, &c, &d, &a, &msg[12]);

   Self::md4_func_g::< 3>(&mut a, &b, &c, &d, &msg[1]);
   Self::md4_func_g::< 5>(&mut d, &a, &b, &c, &msg[5]);
   Self::md4_func_g::< 9>(&mut c, &d, &a, &b, &msg[9]);
   Self::md4_func_g::<13>(&mut b, &c, &d, &a, &msg[13]);

   Self::md4_func_g::< 3>(&mut a, &b, &c, &d, &msg[2]);
   Self::md4_func_g::< 5>(&mut d, &a, &b, &c, &msg[6]);
   Self::md4_func_g::< 9>(&mut c, &d, &a, &b, &msg[10]);
   Self::md4_func_g::<13>(&mut b, &c, &d, &a, &msg[14]);

   Self::md4_func_g::< 3>(&mut a, &b, &c, &d, &msg[3]);
   Self::md4_func_g::< 5>(&mut d, &a, &b, &c, &msg[7]);
   Self::md4_func_g::< 9>(&mut c, &d, &a, &b, &msg[11]);
   Self::md4_func_g::<13>(&mut b, &c, &d, &a, &msg[15]);

   // Third Round
   Self::md4_func_h::< 3>(&mut a, &b, &c, &d, &msg[0]);
   Self::md4_func_h::< 9>(&mut d, &a, &b, &c, &msg[8]);
   Self::md4_func_h::<11>(&mut c, &d, &a, &b, &msg[4]);
   Self::md4_func_h::<15>(&mut b, &c, &d, &a, &msg[12]);

   Self::md4_func_h::< 3>(&mut a, &b, &c, &d, &msg[2]);
   Self::md4_func_h::< 9>(&mut d, &a, &b, &c, &msg[10]);
   Self::md4_func_h::<11>(&mut c, &d, &a, &b, &msg[6]);
   Self::md4_func_h::<15>(&mut b, &c, &d, &a, &msg[14]);

   Self::md4_func_h::< 3>(&mut a, &b, &c, &d, &msg[1]);
   Self::md4_func_h::< 9>(&mut d, &a, &b, &c, &msg[9]);
   Self::md4_func_h::<11>(&mut c, &d, &a, &b, &msg[5]);
   Self::md4_func_h::<15>(&mut b, &c, &d, &a, &msg[13]);

   Self::md4_func_h::< 3>(&mut a, &b, &c, &d, &msg[3]);
   Self::md4_func_h::< 9>(&mut d, &a, &b, &c, &msg[11]);
   Self::md4_func_h::<11>(&mut c, &d, &a, &b, &msg[7]);
   Self::md4_func_h::<15>(&mut b, &c, &d, &a, &msg[15]);

let aa = Simd::<i32, LANES>::splat(0x67452301u32 as i32);
let bb = Simd::<i32, LANES>::splat(0xefcdab89u32 as i32);
let cc = Simd::<i32, LANES>::splat(0x98badcfeu32 as i32);
let dd = Simd::<i32, LANES>::splat(0x10325476u32 as i32);
   return (a + aa, b + bb, c + cc, d + dd);
}

pub fn digest<F>(msgs: &[[u32; LANES]; BLOCK_SIZE], f: &mut F)
    where F: FnMut([u32; 4]) {
   
  
    // --- Compute Digest ---
    let dg = Self::iter([
        Simd::from_array(msgs[0]).cast(),
        Simd::from_array(msgs[1]).cast(),
        Simd::from_array(msgs[2]).cast(),
        Simd::from_array(msgs[3]).cast(),
        Simd::from_array(msgs[4]).cast(),
        Simd::from_array(msgs[5]).cast(),
        Simd::from_array(msgs[6]).cast(),
        Simd::from_array(msgs[7]).cast(),
        Simd::from_array(msgs[8]).cast(),
        Simd::from_array(msgs[9]).cast(),
        Simd::from_array(msgs[10]).cast(),
        Simd::from_array(msgs[11]).cast(),
        Simd::from_array(msgs[12]).cast(),
        Simd::from_array(msgs[13]).cast(),
        Simd::from_array(msgs[14]).cast(),
        Simd::from_array(msgs[15]).cast()
    ]);

   
    for i in 0..LANES {
        let hash: [u32; 4] = [
            i32::cast_unsigned(dg.0[i]),
            i32::cast_unsigned(dg.1[i]),
            i32::cast_unsigned(dg.2[i]),
            i32::cast_unsigned(dg.3[i]),
        ];
   
        f(hash);
    }
}
}

#[cfg(target_arch = "aarch64")]
pub fn supported_lane_count(lanes: usize) -> bool {
return lanes == 4 && std::arch::is_aarch64_feature_detected!("neon");
}

#[cfg(target_arch = "x86_64")]
pub fn supported_lane_count(lanes: usize) -> bool {
return match lanes {
4 => std::arch::is_x86_feature_detected!("sse2"),
8 => std::arch::is_x86_feature_detected!("avx2"),
16 => std::arch::is_x86_feature_detected!("avx512f"),
_ => false,
}
}

#[allow(dead_code)]
pub fn max_lane_count() -> usize {
return if supported_lane_count(16) {
16
} else if supported_lane_count(8) {
8
} else if supported_lane_count(4) {
4
} else {
0
};
}

#[allow(dead_code)]
pub fn new_sse2<const TRAIL_LEN: usize>() -> Option<SimdHasher<4, TRAIL_LEN>> {
if supported_lane_count(4)  {
let mut hasher = SimdHasher{
pattern: [0u32; BLOCK_SIZE],
msgs: [[0u32; 4]; BLOCK_SIZE],
pos: 0,
};
hasher.init_pattern();
return Some(hasher);
} else {
return None;
}
}

#[allow(dead_code)]
pub fn new_avx2<const TRAIL_LEN: usize>() -> Option<SimdHasher<8, TRAIL_LEN>> {
if supported_lane_count(8) {
let mut hasher = SimdHasher{
pattern: [0u32; BLOCK_SIZE],
msgs: [[0u32; 8]; BLOCK_SIZE],
pos: 0,
};
hasher.init_pattern();
return Some(hasher);
} else {
return None;
}
}

#[allow(dead_code)]
pub fn new_avx512<const TRAIL_LEN: usize>() -> Option<SimdHasher<16, TRAIL_LEN>> {
if supported_lane_count(16) {
let mut hasher = SimdHasher{
pattern: [0u32; BLOCK_SIZE],
msgs: [[0u32; 16]; BLOCK_SIZE],
pos: 0,
};
hasher.init_pattern();
return Some(hasher);
} else {
return None;
}
}

#[cfg(test)]
mod tests {
use super::*;

#[test]
fn test_md4() {
    let msgs: [[u32; 4]; 16] = [
    [0x00410041, 0, 0, 0],
    [0x00410041, 0, 0, 0],
    [0x00800041, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0x50, 0, 0, 0],
    [0, 0, 0, 0],
    ];

    let mut i = 0;
    SimdHasher::<4, 4>::digest(&msgs, &mut |digest: [u32; 4]| {
    if i == 0 {
    assert_eq!(digest[0], 0x01d543ac);
    assert_eq!(digest[1], 0xd357146e);
    assert_eq!(digest[2], 0xae9c40af);
    assert_eq!(digest[3], 0x9a3ba7c0);
    }
    i += 1;
    })
}
}
