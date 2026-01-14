// Implementation of the CHD perfect hash function algorithm
// Derived from cmph <https://cmph.sourceforge.net> under LGPL
use std::fmt::Debug;
use std::cmp::PartialEq;

pub struct Config {
	pub keys_per_bucket: u32,
	pub keys_per_bin: u8,
	pub load_factor: f64,
}

pub struct Phf<T: Debug + Default + Copy> {
	n: usize,
	nbuckets: usize,
	cs: compressed_seq::Seq,
	data: Box<[T]>,
	hash_seed: u32,
}

#[derive(Default, Clone)]
struct Bucket {
	items_list: u32,
	value: u32,
}

#[derive(Debug, Default, Clone)]
struct Item {
	f: u32,
	h: u32,
	original_pos: usize,
}

#[derive(Default, Clone)]
struct MapItem {
	f: u32,
	h: u32,
	bucket_num: u32,
	original_pos: usize,
}

#[derive(Default, Clone)]
struct SortedList {
	buckets_list: u32,
	size: u32,
}

impl<T: Debug + Default + Copy + PartialEq> Phf<T> {
	pub fn new(cfg: &Config, data: Box<[T]>) -> Result<Phf<T>, Error> {
		let m = data.len();

		let nbuckets = (m / usize::try_from(cfg.keys_per_bucket)
			.expect("Cannot cast u32 to usize")) + 1;
		let n = Self::gen_n(m, cfg);
		let mut buckets = vec![Bucket::default(); nbuckets].into_boxed_slice();
		let mut items = vec![Item::default(); m].into_boxed_slice();

		const MAX_PROBES_DEFAULT: u32 = 1 << 20;
		let mut max_probes = (f64::from(u32::try_from(m)
			.expect("Cannot convert usize to u32")).ln() / 2.0f64.ln() / 20f64) as u32;
		if max_probes == 0 {
			max_probes = MAX_PROBES_DEFAULT;
		} else {
			max_probes *= MAX_PROBES_DEFAULT;
		}

		let mut iterations = 100;
		let mut max_bucket_size;
		let mut hash_seed;
		let mut sorted_list;
		let mut disp_table = vec![0u32; buckets.len()].into_boxed_slice();
		loop {
			iterations -= 1;
			(max_bucket_size, hash_seed) =
				Self::ph_mapping(&data, &mut buckets, &mut items, n)?;
			let (sorted_list2, buckets2, items2) =
				Self::ph_ordering(&mut buckets, &mut items, max_bucket_size);
			buckets = buckets2;
			items = items2;
			sorted_list = sorted_list2;
			if let Some(_) = Self::ph_searching(&cfg, &buckets, &items,
				max_bucket_size, &sorted_list, max_probes, n, &mut disp_table) {
				break;
			}

			if iterations == 0 {
				return Err(Error::Iterations(100));
			}
		}

		let cs = compressed_seq::Seq::new(&disp_table);

		// Re-order data according to new positions
		let mut newdata = vec![T::default(); n];
		let n32 = u32::try_from(n).expect("Cannot cast usize to u32");
		let nbuckets32 = u32::try_from(nbuckets).expect("Cannot cast usize to u32");
		for e in data {
			let hash = jenkins::Hash::from_seed(hash_seed);
			let hl = hash.hash_vector(Self::cast_to_u8_ptr(&e));
			let g = hl.0 % nbuckets32;
			let f = hl.1 % n32;
			let h = hl.2 % (n32 - 1) + 1;
			let Some(disp) = cs.query(g) else {panic!("CS query failed");};
			let probe0 = disp % n32;
			let probe1 = disp / n32;
			let pos = usize::try_from((((f as u64) + ((h as u64) * (probe0 as u64))
				+ (probe1 as u64)) as u32) % n32)
				.expect("Cannot cast u32 to usize");
			newdata[pos] = e;
		}
		return Ok(Phf{
			n: n,
			nbuckets: nbuckets,
			cs: cs,
			hash_seed: hash_seed,
			data: newdata.into(),
		});
	}

	pub fn query_pos(&self, key: &T) -> Option<usize> {
		let hash = jenkins::Hash::from_seed(self.hash_seed);
		let hl = hash.hash_vector(Self::cast_to_u8_ptr(&key));
		let n32 = u32::try_from(self.n).expect("Cannot cast usize to u32");
		let g = hl.0 % u32::try_from(self.nbuckets).expect("Cannot cast usize to u32");
		let f = hl.1 % n32;
		let h = hl.2 % (n32 - 1) + 1;

		if let Some(disp) = self.cs.query(g) {
			let probe0 = disp % n32;
			let probe1 = disp / n32;
			let pos = usize::try_from((((f as u64) + (h as u64) * (probe0 as u64)
				+ (probe1 as u64)) as u32) % n32)
				.expect("Cannot cast u32 to usize");
			return Some(pos);
		}
		return None;
	}

	#[allow(dead_code)]
	pub fn query(&self, key: &T) -> Option<T> {
		if let Some(pos) = self.query_pos(key) {
			return Some(self.data[pos]);
		}
		return None;
	}

	pub fn has(&self, key: &T) -> bool {
		if let Some(pos) = self.query_pos(key) {
			return &self.data[pos] == key;
		}
		return false;
	}

	fn ph_bucket_clean(buckets: &mut[Bucket]) {
		let len = buckets.len();
		for i in 0..len {
			buckets[i].value = 0;
		}
	}

	fn ph_bucket_insert(buckets: &mut[Bucket], map_items: &mut[MapItem],
		items: &mut[Item], idx: usize) -> bool {
		let bucket_num = usize::try_from(map_items[idx].bucket_num)
			.expect("Cannot cast u32 to usize");
		let mut item_off = usize::try_from(buckets[bucket_num].items_list)
			.expect("Cannot cast u32 to usize");
		for _ in 0..buckets[bucket_num].value {
			if items[item_off].f == map_items[idx].f &&
				items[item_off].h == map_items[idx].h {
				return false;
			}
			item_off += 1;
		}

		items[item_off].f = map_items[idx].f;
		items[item_off].h = map_items[idx].h;
		items[item_off].original_pos = map_items[idx].original_pos;
		buckets[bucket_num].value += 1;
		return true;
	}

	fn ph_mapping(data: &[T], buckets: &mut[Bucket], items: &mut[Item], n: usize)
		-> Result<(usize, u32), Error> {
		let mut max_bucket_size = 0;
		let m: usize = items.len();
		let nbuckets = buckets.len();
		let nbuckets32 = u32::try_from(nbuckets)
			.expect("Cannot cast usize to u32");
		let n = u32::try_from(n).expect("Cannot cast usize to u32");
		let mut map_items = vec![MapItem::default(); m].into_boxed_slice();
		let mut iterations = 1000;
		'outer: loop {
			iterations -= 1;
			let hash = jenkins::Hash::new();
			Self::ph_bucket_clean(buckets);

			for i in 0..m {
				let hl = hash.hash_vector(Self::cast_to_u8_ptr(&data[i]));
				let g32 = hl.0 % nbuckets32;
				let g = usize::try_from(g32)
					.expect("Cannot cast u32 to usize");
				map_items[i] = MapItem{
					f: hl.1 % n,
					h: hl.2 % (n - 1) + 1,
					bucket_num: g32,
					original_pos: i,
				};
				buckets[g].value += 1;
				if buckets[g].value > max_bucket_size {
					max_bucket_size = buckets[g].value;
				}
			}

			buckets[0].items_list = 0;
			for i in 1..nbuckets {
				buckets[i].items_list = buckets[i-1].items_list + buckets[i-1].value;
				buckets[i-1].value = 0;
			}
			buckets[nbuckets-1].value = 0;
			#[allow(unused_labels)]
			'inner: for i in 0..m {
				if !Self::ph_bucket_insert(buckets, &mut map_items, items, i) {
					if iterations == 0 {
						return Err(Error::Iterations(1000));
					}
					continue 'outer;
				}
			}
			return Ok((usize::try_from(max_bucket_size)
				.expect("Cannot cast u32 to usize"), hash.seed))
		}
	}

	fn ph_ordering(buckets: &mut[Bucket], items: &mut[Item], max_bucket_size: usize)
		-> (Box<[SortedList]>, Box<[Bucket]>, Box<[Item]>) {
		let nbuckets = buckets.len();
		let m = items.len();

		let mut sorted_lists = vec![SortedList::default(); max_bucket_size + 1]
			.into_boxed_slice();

		for i in 0..nbuckets {
			let bucket_size = buckets[i].value;
			if bucket_size > 0 {
				let bucket_size_us = usize::try_from(bucket_size)
					.expect("Cannot cast u32 to usize");
				sorted_lists[bucket_size_us].size += 1;
			}
		}

		// Determine final position of list of buckets in bucket contiguous array
		sorted_lists[1].buckets_list = 0;
		for i in 2..=max_bucket_size {
			sorted_lists[i].buckets_list =
				sorted_lists[i-1].buckets_list + sorted_lists[i-1].size;
				sorted_lists[i-1].size = 0;
		}
		sorted_lists[max_bucket_size].size = 0;

		// Store buckets in new array sorted by bucket size
		let mut pos: usize;
		let mut output_buckets = vec![Bucket::default(); nbuckets].into_boxed_slice();
		for i in 0..nbuckets {
			let bucket_size = buckets[i].value;
			if bucket_size > 0 {
				let bucket_size_us = usize::try_from(bucket_size)
					.expect("Cannot cast u32 to usize");
				pos = usize::try_from(sorted_lists[bucket_size_us].buckets_list +
					sorted_lists[bucket_size_us].size).expect("Cannot cast u32 to usize");
				output_buckets[pos].value = u32::try_from(i)
					.expect("Cannot cast usize to u32");
				output_buckets[pos].items_list = buckets[i].items_list;
				sorted_lists[bucket_size_us].size += 1;
			}
		}

		// Store items according to new order of buckets
		let mut output_items = vec![Item::default(); m].into_boxed_slice();
		let mut pos: usize = 0;
		for bucket_size in 1..=max_bucket_size {
			let start = usize::try_from(sorted_lists[bucket_size].buckets_list)
				.expect("Cannot cast u32 to usize");
			let end = usize::try_from(sorted_lists[bucket_size].size
				+ sorted_lists[bucket_size].buckets_list)
				.expect("Cannot cast u32 to usize");
			for i in start..end {
				let mut pos2 = usize::try_from(output_buckets[i].items_list)
					.expect("Cannot cast u32 to usize");
				output_buckets[i].items_list = u32::try_from(pos)
					.expect("Cannot cast usize to u32");
				for _ in 0..bucket_size {
					output_items[pos].f = items[pos2].f;
					output_items[pos].h = items[pos2].h;
					output_items[pos].original_pos = items[pos2].original_pos;
					pos += 1;
					pos2 += 1;
				}
			}
		}

		return (sorted_lists, output_buckets, output_items);
	}

	fn ph_searching(cfg: &Config, buckets: &[Bucket], items: &[Item], max_bucket_size: usize,
		sorted_lists: &[SortedList], max_probes: u32, n: usize, disp_table: &mut[u32])
		-> Option<Box<[u8]>> {
		let occup_table_size = if cfg.keys_per_bin == 1 { ((n + 31) / 32) * 32 } else {n};
		let mut occup_table = vec![0u8; occup_table_size].into_boxed_slice();
		let mut curr_bucket;
		let mut i = max_bucket_size;
		while i > 0 {
			curr_bucket = sorted_lists[i].buckets_list;
			while curr_bucket < (sorted_lists[i].size + sorted_lists[i].buckets_list) {
				let curr_bucket_usize = usize::try_from(curr_bucket)
					.expect("Cannot cast u32 to usize");
				if !Self::ph_place_bucket(cfg, buckets, items, max_probes, disp_table,
					&mut occup_table, curr_bucket_usize, i, n) {
					return None;
				}
				curr_bucket += 1;
			}
			i -= 1;
		}
		return Some(occup_table);
	}

	fn ph_place_bucket(cfg: &Config, buckets: &[Bucket], items: &[Item], max_probes: u32,
		disp_table: &mut[u32], occup_table: &mut[u8], bucket_num: usize, size: usize,
		n: usize) -> bool {
		let mut probe0 = 0;
		let mut probe1 = 0;
		let mut probe = 0;
		loop {
			if Self::ph_bucket_probe(cfg, buckets, items, probe0, probe1,
				bucket_num, size, n, occup_table) {
				let pos = usize::try_from(buckets[bucket_num].value)
					.expect("Cannot cast u32 to usize");
				disp_table[pos] = u32::try_from(probe0 + probe1 * n)
					.expect("Cannot cast usize to u32");
				return true;
			}
			probe0 += 1;
			if probe0 >= n {
				probe0 -= n;
				probe1 += 1;
			}
			probe += 1;
			if probe >= max_probes || probe1 >= n {
				return false;
			}
		}
	}

	fn ph_bucket_probe(cfg: &Config, buckets: &[Bucket], items: &[Item],
		probe0: usize, probe1: usize, bucket_num: usize, size: usize, n: usize,
		occup_table: &mut[u8]) -> bool {

		// Placement
		let mut fail: Option<usize> = None;
		let pos0 = usize::try_from(bucket_num).expect("Cannot cast u32 to usize");
		let pos1 = usize::try_from(buckets[pos0].items_list).expect("Cannot cast u32 to usize");
		if cfg.keys_per_bin > 1 {
			for i in 0..size {
				let item = &items[pos1 + i];
				let pos = usize::try_from((((item.f as u64) + (item.h as u64)
					* (probe0 as u64) + (probe1 as u64)) as u32) % u32::try_from(n)
					.expect("Cannot cast usize to u32")).expect("Cannot cast u32 to usize");
				if occup_table[pos] >= cfg.keys_per_bin {
					fail = Some(i);
					break;
				}
				occup_table[pos] += 1;
			}
		} else {
			for i in 0..size {
				let item = &items[pos1 + i];
				let pos = usize::try_from((((item.f as u64) + (item.h as u64)
					* (probe0 as u64) + (probe1 as u64)) as u32) % u32::try_from(n)
					.expect("Cannot cast usize to u32")).expect("Cannot cast u32 to usize");
				if bits::getbit32(&occup_table, pos) {
					fail = Some(i);
					break;
				}
				bits::setbit32(occup_table, pos);
			}
		}

		// Undo placement
		if let Some(mut len) = fail {
			if cfg.keys_per_bin > 1 {
				let mut i = 0;
				loop {
					if len == 0 {break;}
					let item = &items[pos1 + i];
					let pos = usize::try_from((((item.f as u64) + (item.h as u64)
						* (probe0 as u64) + (probe1 as u64)) as u32) % u32::try_from(n)
						.expect("Cannot cast usize to u32")).expect("Cannot cast u32 to usize");
					occup_table[pos] -= 1;
					len -= 1;
					i += 1;
				}
			} else {
				let mut i = 0;
				loop {
					if len == 0 {break;}
					let item = &items[pos1 + i];
					let pos = usize::try_from((((item.f as u64) + (item.h as u64)
						* (probe0 as u64) + (probe1 as u64)) as u32) % u32::try_from(n)
						.expect("Cannot cast usize to u32")).expect("Cannot cast u32 to usize");
					bits::unsetbit32(occup_table, pos);
					len -= 1;
					i += 1;
				}
			}
			return false;
		}
		return true;
	}

	fn cast_to_u8_ptr(ptr: &T) -> &[u8] {
		unsafe {
			core::slice::from_raw_parts(
				(ptr as *const T) as *const u8,
				core::mem::size_of::<T>(),
			)
		}
	}

	#[inline]
	fn gen_n(m: usize, cfg: &Config) -> usize {
		let load_factor = cfg.load_factor.clamp(0.5, 0.99);
		let m32 = u32::try_from(m).expect("Cannot cast usize to u32");
		let keys_per_bin_f64 = f64::from(cfg.keys_per_bin);
		let mut n: usize = ((f64::from(m32) / (keys_per_bin_f64 * load_factor)) as usize) + 1;
		n += (n % 2 == 0) as usize;
		while !miller_rabin::is_prime(u64::try_from(n)
				.expect("Cannot convert usize to u64")) {
			n += 2;
		}
		return n;
	}
}


#[derive(Debug)]
pub enum Error {
    Iterations(usize),
}

impl std::fmt::Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Error::Iterations(n) => write!(f, "Could not find PHF in {} iterations", n)
        }
    }
}

impl std::error::Error for Error {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        match self {
            Error::Iterations(_) => None,
        }
    }
}

mod jenkins {
	use rand::Rng;

	#[derive(Debug)]
	pub struct Hash {
		pub seed: u32,
	}

	impl Hash {
		pub fn new() -> Hash {
			let mut rng = rand::rng();
			Hash{seed: rng.random::<u32>()}
		}

		pub fn from_seed(seed: u32) -> Hash {
			Hash{seed: seed}
		}

		pub fn mix(a: u32, b: u32, c: u32) -> (u32, u32, u32) {
			let mut a = a;
			let mut b = b;
			let mut c = c;
			
			a = a.wrapping_sub(b).wrapping_sub(c); a ^= c >> 13;
			b = b.wrapping_sub(c).wrapping_sub(a); b ^= a << 8;
			c = c.wrapping_sub(a).wrapping_sub(b); c ^= b >> 13;
			a = a.wrapping_sub(b).wrapping_sub(c); a ^= c >> 12;
			b = b.wrapping_sub(c).wrapping_sub(a); b ^= a << 16;
			c = c.wrapping_sub(a).wrapping_sub(b); c ^= b >> 5;
			a = a.wrapping_sub(b).wrapping_sub(c); a ^= c >> 3;
			b = b.wrapping_sub(c).wrapping_sub(a); b ^= a << 10;
			c = c.wrapping_sub(a).wrapping_sub(b); c ^= b >> 15;

			(a, b, c)
		}

		pub fn hash_vector(&self, key: &[u8]) -> (u32, u32, u32) {
			let mut a: u32 = 0x9e3779b9;
			let mut b: u32 = 0x9e3779b9;
			let mut c: u32 = self.seed;

			let len = key.len();
			let end = len - (len % 12);
			for i in (0..end).step_by(12) {
				let k = &key[i..i+12];
				a = a.wrapping_add(k[11] as u32)
					 .wrapping_add((k[10] as u32) << 8)
					 .wrapping_add((k[9] as u32) << 16)
					 .wrapping_add((k[8] as u32) << 24);
				b = b.wrapping_add(k[7] as u32)
					 .wrapping_add((k[6] as u32) << 8)
					 .wrapping_add((k[5] as u32) << 16)
					 .wrapping_add((k[4] as u32) << 24);
				c = c.wrapping_add(k[3] as u32)
					 .wrapping_add((k[2] as u32) << 8)
					 .wrapping_add((k[1] as u32) << 16)
					 .wrapping_add((k[0] as u32) << 24);
				(a, b, c) = Self::mix(a, b, c);
			}
			c = c.wrapping_add(u32::try_from(len)
				.expect("Cannot cast usize to u32"));

			let k = &key[end..];
			match len % 12 {
				11 => {
					c = c.wrapping_add((k[0] as u32) << 24);
					c = c.wrapping_add((k[1] as u32) << 16);
					c = c.wrapping_add((k[2] as u32) << 8);
					b = b.wrapping_add((k[3] as u32) << 24);
					b = b.wrapping_add((k[4] as u32) << 16);
					b = b.wrapping_add((k[5] as u32) << 8);
					b = b.wrapping_add((k[6] as u32) & 0xff);
					a = a.wrapping_add((k[7] as u32) << 24);
					a = a.wrapping_add((k[8] as u32) << 16);
					a = a.wrapping_add((k[9] as u32) << 8);
					a = a.wrapping_add((k[10] as u32) & 0xff);
				},
				10 => {
					c = c.wrapping_add((k[0] as u32) << 16);
					c = c.wrapping_add((k[1] as u32) << 8);
					b = b.wrapping_add((k[2] as u32) << 24);
					b = b.wrapping_add((k[3] as u32) << 16);
					b = b.wrapping_add((k[4] as u32) << 8);
					b = b.wrapping_add((k[5] as u32) & 0xff);
					a = a.wrapping_add((k[6] as u32) << 24);
					a = a.wrapping_add((k[7] as u32) << 16);
					a = a.wrapping_add((k[8] as u32) << 8);
					a = a.wrapping_add((k[9] as u32) & 0xff);
				},
				9 => {
					c = c.wrapping_add((k[0] as u32) << 8);
					b = b.wrapping_add((k[1] as u32) << 24);
					b = b.wrapping_add((k[2] as u32) << 16);
					b = b.wrapping_add((k[3] as u32) << 8);
					b = b.wrapping_add((k[4] as u32) & 0xff);
					a = a.wrapping_add((k[5] as u32) << 24);
					a = a.wrapping_add((k[6] as u32) << 16);
					a = a.wrapping_add((k[7] as u32) << 8);
					a = a.wrapping_add((k[8] as u32) & 0xff);
				},
				8 => {
					b = b.wrapping_add((k[0] as u32) << 24);
					b = b.wrapping_add((k[1] as u32) << 16);
					b = b.wrapping_add((k[2] as u32) << 8);
					b = b.wrapping_add((k[3] as u32) & 0xff);
					a = a.wrapping_add((k[4] as u32) << 24);
					a = a.wrapping_add((k[5] as u32) << 16);
					a = a.wrapping_add((k[6] as u32) << 8);
					a = a.wrapping_add((k[7] as u32) & 0xff);
				},
				7 => {
					b = b.wrapping_add((k[0] as u32) << 16);
					b = b.wrapping_add((k[1] as u32) << 8);
					b = b.wrapping_add((k[2] as u32) & 0xff);
					a = a.wrapping_add((k[3] as u32) << 24);
					a = a.wrapping_add((k[4] as u32) << 16);
					a = a.wrapping_add((k[5] as u32) << 8);
					a = a.wrapping_add((k[6] as u32) & 0xff);
				},
				6 => {
					b = b.wrapping_add((k[0] as u32) << 8);
					b = b.wrapping_add((k[1] as u32) & 0xff);
					a = a.wrapping_add((k[2] as u32) << 24);
					a = a.wrapping_add((k[3] as u32) << 16);
					a = a.wrapping_add((k[4] as u32) << 8);
					a = a.wrapping_add((k[5] as u32) & 0xff);
				},
				5 => {
					b = b.wrapping_add((k[0] as u32) & 0xff);
					a = a.wrapping_add((k[1] as u32) << 24);
					a = a.wrapping_add((k[2] as u32) << 16);
					a = a.wrapping_add((k[3] as u32) << 8);
					a = a.wrapping_add((k[4] as u32) & 0xff);
				},
				4 => {
					a = a.wrapping_add((k[0] as u32) << 24);
					a = a.wrapping_add((k[1] as u32) << 16);
					a = a.wrapping_add((k[2] as u32) << 8);
					a = a.wrapping_add((k[3] as u32) & 0xff);
				},
				3 => {
					a = a.wrapping_add((k[0] as u32) << 16);
					a = a.wrapping_add((k[1] as u32) << 8);
					a = a.wrapping_add((k[2] as u32) & 0xff);
				},
				2 => {
					a = a.wrapping_add((k[0] as u32) << 8);
					a = a.wrapping_add((k[1] as u32) & 0xff);
				},
				1 => {
					a = a.wrapping_add((k[0] as u32) & 0xff);
				},
				_ => unreachable!(),
			}
			return Self::mix(a, b, c);
		}
	}
}

mod compressed_seq {
	pub struct Seq {
		n: u32,
		rem_r: u32,
		sel: super::select::Select,
		length_rems: Box<[u32]>,
		store_table: Box<[u32]>,
	}

	impl Seq {
		pub fn new(values: &[u32]) -> Seq {
			let n = values.len();
			let n32 = u32::try_from(n).expect("Cannot convert usize to u32");
			let mut lengths = vec![0u32; n].into_boxed_slice();

			let mut total_length: u32 = 0;
			for i in 0..n {
				if values[i] == 0 {
					lengths[i] = 0;
				} else {
					let length = Self::i_log2(values[i] + 1);
					lengths[i] = length;
					total_length += length;
				}
			}

			let store_table_len = usize::try_from((total_length + 31) >> 5)
				.expect("Cannot convert u32 to usize");
			let mut store_table = vec![0u32; store_table_len].into_boxed_slice();
			total_length = 0;
			for i in 0..n {
				if values[i] == 0 { continue; }
				let stored_value: u32 = values[i] - ((1u32 << lengths[i]) - 1u32);
				super::bits::set_bits_at_pos(&mut store_table, total_length,
					stored_value, lengths[i]);
				total_length += lengths[i];
			}

			let rem_r = Self::i_log2(total_length / n32).clamp(1, u32::MAX);
			let length_rems_len = usize::try_from(super::bits::bits_table_size(n32, rem_r))
				.expect("Cannot convert u32 to usize");
			let mut length_rems = vec![0u32; length_rems_len]
				.into_boxed_slice();
			let rems_mask: u32 = (1u32 << rem_r) - 1u32;

			total_length = 0;
			for i in 0..n {
				total_length += lengths[i];
				let i_32 = u32::try_from(i).expect("Cannot convert usize to u32");
				super::bits::set_bits_value(&mut length_rems, i_32, total_length & rems_mask,
					rem_r, rems_mask);
				lengths[i] = total_length >> rem_r;
			}

			Seq {
				n: n32,
				rem_r: rem_r,
				sel: super::select::Select::new(&lengths, n32, total_length >> rem_r),
				length_rems: length_rems,
				store_table: store_table,
			}
		}

		pub fn query(&self, idx: u32) -> Option<u32> {
			if idx >= self.n {
				return None;
			}

			let rems_mask = (1u32 << self.rem_r) - 1u32;
			let (enc_idx, sel_res) = if idx == 0 {
				(0, self.sel.query(idx))
			} else {
				let sel_res = self.sel.query(idx - 1);
				let enc_base = (sel_res - (idx - 1)) << self.rem_r;
				let enc_idx = enc_base + super::bits::get_bits_value(&self.length_rems,
					idx - 1, self.rem_r, rems_mask);
				(enc_idx, self.sel.next_query(sel_res))
			};

			let mut enc_length = (sel_res - idx) << self.rem_r;
			enc_length += super::bits::get_bits_value(&self.length_rems, idx,
				self.rem_r, rems_mask);
			enc_length -= enc_idx;
			if enc_length == 0 { return Some(0u32); }

			let stored_value: u32 = super::bits::get_bits_at_pos(&self.store_table,
				enc_idx, enc_length);
			return Some(stored_value + ((1u32 << enc_length) - 1u32));
		}

		fn i_log2(x: u32) -> u32 {
			let mut x = x;
			let mut res: u32 = 0;
			while x > 1 {
				x >>= 1;
				res += 1;
			}
			return res;
		}
	}
}

mod bits {
	const BITMASK32: [u32; 32] = [
		1,       1 << 1,  1 << 2,  1 << 3,  1 << 4,  1 << 5,  1 << 6, 1 << 7,
		1 << 8,  1 << 9,  1 << 10, 1 << 11, 1 << 12, 1 << 13, 1 << 14, 1 << 15,
		1 << 16, 1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 21, 1 << 22, 1 << 23,
		1 << 24, 1 << 25, 1 << 26, 1 << 27, 1 << 28, 1 << 29, 1 << 30, 1 << 31
	];

	#[inline]
	pub fn getbit32(array: &[u8], i: usize) -> bool {
		let array32: &[u32] = unsafe {
			std::slice::from_raw_parts(
				array.as_ptr() as *const u32,
				array.len() / 4
			)
		};
		array32[i >> 5] & self::BITMASK32[i & 0x0000001f] > 0
	}

	#[inline]
	pub fn setbit32(array: &mut[u8], i: usize) {
		let array32: &mut [u32] = unsafe {
			std::slice::from_raw_parts_mut(
				array.as_mut_ptr() as *mut u32,
				array.len() / 4
			)
		};
		array32[i >> 5] |= self::BITMASK32[i & 0x0000001f];
	}

	#[inline]
	pub fn unsetbit32(array: &mut[u8], i: usize) {
		let array32: &mut [u32] = unsafe {
			std::slice::from_raw_parts_mut(
				array.as_mut_ptr() as *mut u32,
				array.len() / 4
			)
		};
		array32[i >> 5] ^= self::BITMASK32[i & 0x0000001f];
	}

	#[inline]
	pub fn bits_table_size(n: u32, bits_length: u32) -> u32 {
		(n * bits_length + 31) / 32
	}

	pub fn set_bits_at_pos(table: &mut[u32], pos: u32, bits: u32, len: u32) {
		let word_idx = usize::try_from(pos / 32).expect("Cannot convert u32 to usize");
		let shift1 = pos & 0x0000001f;
		let shift2 = 32u32 - shift1;
		let mask = (1u32 << len) - 1;

		table[word_idx] &= !(mask << shift1);
		table[word_idx] |= bits << shift1;

		if shift2 < len {
			table[word_idx + 1] &= !(mask >> shift2);
			table[word_idx + 1] |= bits >> shift2;
		}
	}

	pub fn set_bits_value(table: &mut[u32], idx: u32, bits: u32, len: u32, mask: u32) {
		let bit_idx = idx * len;
		let word_idx = usize::try_from(bit_idx / 32).expect("Cannot convert u32 to usize");
		let shift1 = bit_idx & 0x0000001f;
		let shift2 = 32 - shift1;

		table[word_idx] &= !(mask << shift1);
		table[word_idx] |= bits << shift1;

		if shift2 < len {
			table[word_idx + 1] &= !(mask >> shift2);
			table[word_idx + 1] |= bits >> shift2;
		}
	}

	pub fn get_bits_value(table: &[u32], idx: u32, len: u32, mask: u32) -> u32 {
		let bit_idx = idx * len;
		let word_idx = usize::try_from(bit_idx / 32).expect("Cannot convert u32 to usize");
		let shift1 = bit_idx & 0x0000001f;
		let shift2 = 32 - shift1;

		let mut bits: u32 = (table[word_idx] >> shift1) & mask;
		if shift2 < len {
			bits |= (table[word_idx + 1] << shift2) & mask;
		}
		return bits;
	}

	pub fn get_bits_at_pos(table: &[u32], pos: u32, len: u32) -> u32 {
		let word_idx = usize::try_from(pos >> 5).expect("Cannot convert u32 to usize");
		let shift1 = pos & 0x0000001f;
		let shift2 = 32 - shift1;
		let mask = (1u32 << len) - 1;

		let mut bits: u32 = (table[word_idx] >> shift1) & mask;
		if shift2 < len {
			bits |= (table[word_idx + 1] << shift2) & mask;
		}
		return bits;
	}
}

mod select {
	#[derive(Default)]
	pub struct Select {
		n: u32,
		bits: Box<[u8]>,
		table: Box<[u32]>
	}

	const NBITS_STEP_SELECT_TABLE: u32 = 7;
	const STEP_SELECT_TABLE: u32 = 128;
	const MASK_STEP_SELECT_TABLE: u32 = 0x7f;

	const RANK_LOOKUP_TABLE: [u8; 256] = [
		0 , 1 , 1 , 2 , 1 , 2 , 2 , 3 , 1 , 2 , 2 , 3 , 2 , 3 , 3 , 4
		,  1 , 2 , 2 , 3 , 2 , 3 , 3 , 4 , 2 , 3 , 3 , 4 , 3 , 4 , 4 , 5
		,  1 , 2 , 2 , 3 , 2 , 3 , 3 , 4 , 2 , 3 , 3 , 4 , 3 , 4 , 4 , 5
		,  2 , 3 , 3 , 4 , 3 , 4 , 4 , 5 , 3 , 4 , 4 , 5 , 4 , 5 , 5 , 6
		,  1 , 2 , 2 , 3 , 2 , 3 , 3 , 4 , 2 , 3 , 3 , 4 , 3 , 4 , 4 , 5
		,  2 , 3 , 3 , 4 , 3 , 4 , 4 , 5 , 3 , 4 , 4 , 5 , 4 , 5 , 5 , 6
		,  2 , 3 , 3 , 4 , 3 , 4 , 4 , 5 , 3 , 4 , 4 , 5 , 4 , 5 , 5 , 6
		,  3 , 4 , 4 , 5 , 4 , 5 , 5 , 6 , 4 , 5 , 5 , 6 , 5 , 6 , 6 , 7
		,  1 , 2 , 2 , 3 , 2 , 3 , 3 , 4 , 2 , 3 , 3 , 4 , 3 , 4 , 4 , 5
		,  2 , 3 , 3 , 4 , 3 , 4 , 4 , 5 , 3 , 4 , 4 , 5 , 4 , 5 , 5 , 6
		,  2 , 3 , 3 , 4 , 3 , 4 , 4 , 5 , 3 , 4 , 4 , 5 , 4 , 5 , 5 , 6
		,  3 , 4 , 4 , 5 , 4 , 5 , 5 , 6 , 4 , 5 , 5 , 6 , 5 , 6 , 6 , 7
		,  2 , 3 , 3 , 4 , 3 , 4 , 4 , 5 , 3 , 4 , 4 , 5 , 4 , 5 , 5 , 6
		,  3 , 4 , 4 , 5 , 4 , 5 , 5 , 6 , 4 , 5 , 5 , 6 , 5 , 6 , 6 , 7
		,  3 , 4 , 4 , 5 , 4 , 5 , 5 , 6 , 4 , 5 , 5 , 6 , 5 , 6 , 6 , 7
	,  4 , 5 , 5 , 6 , 5 , 6 , 6 , 7 , 5 , 6 , 6 , 7 , 6 , 7 , 7 , 8 
	];

	const SELECT_LOOKUP_TABLE: [[u8; 8]; 256] = [
		[ 255 , 255 , 255 , 255 , 255 , 255 , 255 , 255 ], [ 0 , 255 , 255 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 255 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 255 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 255 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 255 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 3 , 255 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 255 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 255 , 255 , 255 , 255 ] ,
		[ 4 , 255 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 4 , 255 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 4 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 4 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 4 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 4 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 4 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 4 , 255 , 255 , 255 , 255 ] ,
		[ 3 , 4 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 4 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 4 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 4 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 4 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 4 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 4 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 4 , 255 , 255 , 255 ] ,
		[ 5 , 255 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 5 , 255 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 5 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 5 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 5 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 5 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 5 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 5 , 255 , 255 , 255 , 255 ] ,
		[ 3 , 5 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 5 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 5 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 5 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 5 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 5 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 5 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 5 , 255 , 255 , 255 ] ,
		[ 4 , 5 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 4 , 5 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 4 , 5 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 4 , 5 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 4 , 5 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 4 , 5 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 4 , 5 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 4 , 5 , 255 , 255 , 255 ] ,
		[ 3 , 4 , 5 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 4 , 5 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 4 , 5 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 4 , 5 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 4 , 5 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 4 , 5 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 4 , 5 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 4 , 5 , 255 , 255 ] ,
		[ 6 , 255 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 6 , 255 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 6 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 6 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 6 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 6 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 6 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 6 , 255 , 255 , 255 , 255 ] ,
		[ 3 , 6 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 6 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 6 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 6 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 6 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 6 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 6 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 6 , 255 , 255 , 255 ] ,
		[ 4 , 6 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 4 , 6 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 4 , 6 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 4 , 6 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 4 , 6 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 4 , 6 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 4 , 6 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 4 , 6 , 255 , 255 , 255 ] ,
		[ 3 , 4 , 6 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 4 , 6 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 4 , 6 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 4 , 6 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 4 , 6 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 4 , 6 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 4 , 6 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 4 , 6 , 255 , 255 ] ,
		[ 5 , 6 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 5 , 6 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 5 , 6 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 5 , 6 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 5 , 6 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 5 , 6 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 5 , 6 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 5 , 6 , 255 , 255 , 255 ] ,
		[ 3 , 5 , 6 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 5 , 6 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 5 , 6 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 5 , 6 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 5 , 6 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 5 , 6 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 5 , 6 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 5 , 6 , 255 , 255 ] ,
		[ 4 , 5 , 6 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 4 , 5 , 6 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 4 , 5 , 6 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 4 , 5 , 6 , 255 , 255 , 255 ] ,
		[ 2 , 4 , 5 , 6 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 4 , 5 , 6 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 4 , 5 , 6 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 4 , 5 , 6 , 255 , 255 ] ,
		[ 3 , 4 , 5 , 6 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 4 , 5 , 6 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 4 , 5 , 6 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 4 , 5 , 6 , 255 , 255 ] ,
		[ 2 , 3 , 4 , 5 , 6 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 4 , 5 , 6 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 4 , 5 , 6 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 4 , 5 , 6 , 255 ] ,
		[ 7 , 255 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 7 , 255 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 7 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 7 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 7 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 7 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 3 , 7 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 7 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 7 , 255 , 255 , 255 ] ,
		[ 4 , 7 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 4 , 7 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 4 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 4 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 4 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 4 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 4 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 4 , 7 , 255 , 255 , 255 ] ,
		[ 3 , 4 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 4 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 4 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 4 , 7 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 4 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 4 , 7 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 4 , 7 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 4 , 7 , 255 , 255 ] ,
		[ 5 , 7 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 5 , 7 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 5 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 5 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 5 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 5 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 5 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 5 , 7 , 255 , 255 , 255 ] ,
		[ 3 , 5 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 5 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 5 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 5 , 7 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 5 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 5 , 7 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 5 , 7 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 5 , 7 , 255 , 255 ] ,
		[ 4 , 5 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 4 , 5 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 4 , 5 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 4 , 5 , 7 , 255 , 255 , 255 ] ,
		[ 2 , 4 , 5 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 4 , 5 , 7 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 4 , 5 , 7 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 4 , 5 , 7 , 255 , 255 ] ,
		[ 3 , 4 , 5 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 4 , 5 , 7 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 4 , 5 , 7 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 4 , 5 , 7 , 255 , 255 ] ,
		[ 2 , 3 , 4 , 5 , 7 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 4 , 5 , 7 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 4 , 5 , 7 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 4 , 5 , 7 , 255 ] ,
		[ 6 , 7 , 255 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 6 , 7 , 255 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 6 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 6 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 2 , 6 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 6 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 6 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 6 , 7 , 255 , 255 , 255 ] ,
		[ 3 , 6 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 6 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 6 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 6 , 7 , 255 , 255 , 255 ] ,
		[ 2 , 3 , 6 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 6 , 7 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 6 , 7 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 6 , 7 , 255 , 255 ] ,
		[ 4 , 6 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 4 , 6 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 4 , 6 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 4 , 6 , 7 , 255 , 255 , 255 ] ,
		[ 2 , 4 , 6 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 4 , 6 , 7 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 4 , 6 , 7 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 4 , 6 , 7 , 255 , 255 ] ,
		[ 3 , 4 , 6 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 4 , 6 , 7 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 4 , 6 , 7 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 4 , 6 , 7 , 255 , 255 ] ,
		[ 2 , 3 , 4 , 6 , 7 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 4 , 6 , 7 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 4 , 6 , 7 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 4 , 6 , 7 , 255 ] ,
		[ 5 , 6 , 7 , 255 , 255 , 255 , 255 , 255 ] , [ 0 , 5 , 6 , 7 , 255 , 255 , 255 , 255 ] ,
		[ 1 , 5 , 6 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 1 , 5 , 6 , 7 , 255 , 255 , 255 ] ,
		[ 2 , 5 , 6 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 2 , 5 , 6 , 7 , 255 , 255 , 255 ] ,
		[ 1 , 2 , 5 , 6 , 7 , 255 , 255 , 255 ] , [ 0 , 1 , 2 , 5 , 6 , 7 , 255 , 255 ] ,
		[ 3 , 5 , 6 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 3 , 5 , 6 , 7 , 255 , 255 , 255 ] ,
		[ 1 , 3 , 5 , 6 , 7 , 255 , 255 , 255 ] , [ 0 , 1 , 3 , 5 , 6 , 7 , 255 , 255 ] ,
		[ 2 , 3 , 5 , 6 , 7 , 255 , 255 , 255 ] , [ 0 , 2 , 3 , 5 , 6 , 7 , 255 , 255 ] ,
		[ 1 , 2 , 3 , 5 , 6 , 7 , 255 , 255 ] , [ 0 , 1 , 2 , 3 , 5 , 6 , 7 , 255 ] ,
		[ 4 , 5 , 6 , 7 , 255 , 255 , 255 , 255 ] , [ 0 , 4 , 5 , 6 , 7 , 255 , 255 , 255 ] ,
		[ 1 , 4 , 5 , 6 , 7 , 255 , 255 , 255 ] , [ 0 , 1 , 4 , 5 , 6 , 7 , 255 , 255 ] ,
		[ 2 , 4 , 5 , 6 , 7 , 255 , 255 , 255 ] , [ 0 , 2 , 4 , 5 , 6 , 7 , 255 , 255 ] ,
		[ 1 , 2 , 4 , 5 , 6 , 7 , 255 , 255 ] , [ 0 , 1 , 2 , 4 , 5 , 6 , 7 , 255 ] ,
		[ 3 , 4 , 5 , 6 , 7 , 255 , 255 , 255 ] , [ 0 , 3 , 4 , 5 , 6 , 7 , 255 , 255 ] ,
		[ 1 , 3 , 4 , 5 , 6 , 7 , 255 , 255 ] , [ 0 , 1 , 3 , 4 , 5 , 6 , 7 , 255 ] ,
		[ 2 , 3 , 4 , 5 , 6 , 7 , 255 , 255 ] , [ 0 , 2 , 3 , 4 , 5 , 6 , 7 , 255 ] ,
		[ 1 , 2 , 3 , 4 , 5 , 6 , 7 , 255 ] , [ 0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 ]
	];

	impl Select {
		pub fn new(keys_vec: &[u32], n: u32, m: u32) -> Select {
			let vec_size = ((n + m) + 31) >> 5;
			let table_size = (n >> NBITS_STEP_SELECT_TABLE) + 1;
			
			let mut bits = vec![0u32; usize::try_from(vec_size)
				.expect("Cannot cast u32 to usize")].into_boxed_slice();

			let mut idx: u32 = 0;
			let mut i: u32 = 0;
			let mut j: u32 = 0;
			let mut buf: u32 = 0;
			'outer: loop {
				#[allow(unused_labels)]
				'inner: while keys_vec[usize::try_from(j)
					.expect("Cannot cast u32 to usize")] == i {
					buf = (buf >> 1) | 0x80000000;
					idx += 1;
					if (idx & 0x1f) == 0 {
						let off = usize::try_from((idx >> 5) - 1)
							.expect("Cannot cast u32 to usize");
						bits[off] = buf;
					}
					j += 1;
					if j == n {
						break 'outer;
					}
				}

				if i == m {
					break;
				}

				while keys_vec[usize::try_from(j)
					.expect("Cannot cast u32 to usize")] > i {
					idx += 1;
					buf >>= 1;
					if (idx & 0x1f) == 0 {
						let off = usize::try_from((idx >> 5) - 1)
							.expect("Cannot cast u32 to usize");
						bits[off] = buf;
					}
					i += 1;
				}
			}

			if (idx & 0x1f) != 0 {
				buf = buf >> (32 - (idx & 0x1f));
				let off = usize::try_from((idx - 1) >> 5)
					.expect("Cannot cast u32 to usize");
				bits[off] = buf;
			}

			let (_, bits, _) = unsafe {
				bits.align_to::<u8>()
			};

			let mut sel = Select {
				n: n,
				table: vec![0u32; usize::try_from(table_size)
					.expect("Cannot cast u32 to usize")].into_boxed_slice(),
				bits: bits.into(),
			};

			sel.generate_table();
			return sel;
		}

		fn generate_table(&mut self) {
			let mut one_idx = 0;
			let mut old_part_sum;
			let mut part_sum = 0;
			let mut vec_idx = 0;
			let mut sel_table_idx = 0;
			loop {
				if one_idx >= self.n {
					break;
				}

				loop {
					old_part_sum = part_sum;
					let off = usize::try_from(self.bits[vec_idx])
						.expect("Cannot cast u32 to usize");
					part_sum += RANK_LOOKUP_TABLE[off] as u32;
					vec_idx += 1;
					if part_sum > one_idx {
						break;
					}
				}

				let off0 = usize::try_from(vec_idx - 1).expect("Cannot cast u32 to usize");
				let off1 = usize::try_from(one_idx - old_part_sum)
					.expect("Cannot cast u32 to usize");
				let off3 = usize::try_from(self.bits[off0])
					.expect("Cannot convert u32 to usize");
				let skip = u32::try_from((vec_idx - 1) << 3)
					.expect("Cannot convert usize to u32");
				self.table[sel_table_idx] = (SELECT_LOOKUP_TABLE[off3][off1] as u32) + skip;
				one_idx += STEP_SELECT_TABLE;
				sel_table_idx += 1;
			}
		}

		pub fn query(&self, one_idx: u32) -> u32 {
			let off0 = usize::try_from(one_idx >> NBITS_STEP_SELECT_TABLE)
				.expect("Cannot cast u32 to usize");
			let vec_bit_idx = self.table[off0];
			let mut vec_byte_idx = usize::try_from(vec_bit_idx >> 3)
				.expect("Cannot cast u32 to usize");

			let off1 = usize::try_from(self.bits[vec_byte_idx] &
				((1 << (vec_bit_idx & 0x7)) - 1)).expect("Cannot cast u32 to usize");
			let one_idx2 = (one_idx & MASK_STEP_SELECT_TABLE) +
				(RANK_LOOKUP_TABLE[off1] as u32);

			let mut part_sum = 0;
			let mut old_part_sum;
			loop {
				old_part_sum = part_sum;
				part_sum += RANK_LOOKUP_TABLE[usize::try_from(self.bits[vec_byte_idx])
					.expect("Cannot cast u32 to usize")] as u32;
				vec_byte_idx += 1;
				if part_sum > one_idx2 {
					break;
				}
			};

			let off2 = usize::try_from(self.bits[vec_byte_idx - 1])
				.expect("Cannot cast u32 to usize");
			let off3 = usize::try_from(one_idx2 - old_part_sum)
				.expect("Cannot cast u32 to usize");

			let vec_byte_idx2_32 = u32::try_from(vec_byte_idx)
				.expect("Cannot convert usize to u32");
			return (SELECT_LOOKUP_TABLE[off2][off3] as u32) + ((vec_byte_idx2_32 - 1) << 3);
		}

		pub fn next_query(&self, vec_bit_idx: u32) -> u32 {
			let mut vec_byte_idx = usize::try_from(vec_bit_idx >> 3)
				.expect("Cannot cast u32 to usize");
			let off4 = usize::try_from((self.bits[vec_byte_idx] as u32)
				& ((1u32 << (vec_bit_idx & 0x7)) - 1u32))
				.expect("Cannot convert u32 to usize");
			let one_idx = (RANK_LOOKUP_TABLE[off4] as u32) + 1u32;

			let mut old_part_sum;
			let mut part_sum = 0;
			loop {
				old_part_sum = part_sum;
				let off6 = usize::try_from(self.bits[vec_byte_idx])
					.expect("Cannot convert u32 to usize");
				part_sum += RANK_LOOKUP_TABLE[off6] as u32;
				vec_byte_idx += 1;
				if part_sum > one_idx {
					break;
				}
			}

			let off7 = usize::try_from(one_idx - old_part_sum)
				.expect("Cannot convert u32 to usize");
			let vec_byte_idx_32 = u32::try_from(vec_byte_idx)
				.expect("Cannot convert usize to u32");
			let off8 = usize::try_from(self.bits[vec_byte_idx - 1])
				.expect("Cannot convert u32 to usize");
			return (SELECT_LOOKUP_TABLE[off8][off7] as u32)
				+ ((vec_byte_idx_32 - 1) << 3);
		}
	}
}


mod miller_rabin {
	pub fn is_prime(n: u64) -> bool {
		if (n % 2) == 0 || (n % 3) == 0 || (n % 5) == 0 || (n % 7) == 0 {
			return false;
		}

		let mut s: u64 = 1;
		let mut d: u64 = (n - 1) / 2;
		while d % 2 == 0 {
			s += 1;
			d /= 2;
		}

		if !is_witness(int_pow(2, d, n), n, s) {
			return false;
		}
		if !is_witness(int_pow(7, d, n), n, s) {
			return false;
		}
		if !is_witness(int_pow(61, d, n), n, s) {
			return false;
		}
		return true;
	}

	fn int_pow(a: u64, d: u64, n: u64) -> u64 {
		let mut a_pow: u64 = a;
		let mut res: u64 = 1;
		let mut d = d;
		while d > 0 {
			if (d & 1) == 1 {
				res = (res * a_pow) % n;
			}
			a_pow = (a_pow * a_pow) % n;
			d /= 2;
		}
		return res;
	}

	fn is_witness(a_exp: u64, n: u64, s: u64) -> bool {
		if a_exp == 1 || a_exp == (n - 1) {
			return true;
		}

		let mut a_exp = (a_exp * a_exp) % n;
		for _ in 1..s {
			if a_exp == n - 1 {
				return true;
			}
			a_exp = (a_exp * a_exp) % n;
		}

		return false;
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn test_miller_rabin() {
		assert!(!miller_rabin::is_prime(8));
		assert!(miller_rabin::is_prime(11));
		assert!(miller_rabin::is_prime(7883));
		assert!(!miller_rabin::is_prime(7900));
		assert!(!miller_rabin::is_prime(7003));
	}

	#[test]
	fn test_phf() {
		let cfg = Config {keys_per_bucket: 1, keys_per_bin: 1, load_factor: 0.8};
		let data: Box<[u32]> = Box::new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
		let phf = Phf::<u32>::new(&cfg, data).unwrap();

		let key = 2u32;
		assert_eq!(phf.query(&key), Some(2u32));
	}

	#[test]
	fn test_phf_bytes() {
		let cfg = Config {keys_per_bucket: 1, keys_per_bin: 1, load_factor: 0.8};
		let data: Box<[[u32; 2]]> = Box::new([[0x11, 0x11], [0x22, 0x22], [0x33, 0x33], [0x44, 0x44], [0x55, 0x55]]);
		let phf = Phf::<[u32; 2]>::new(&cfg, data).unwrap();

		let key: [u32; 2] = [0x22, 0x22];
		assert!(phf.has(&key));

		let fluke: [u32; 2] = [0x22, 0x23];
		assert!(!phf.has(&fluke));
	}
}
