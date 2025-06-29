// Error types for reading and seeking operations

///|
priv suberror ReadError {
  EndOfStream
  InvalidFormat(String)
  BufferUnderflow(Int) // expected bytes
} derive(Eq, Show)

///|
priv suberror SeekError {
  InvalidPosition(Int64)
  SeekOutOfBounds(Int64, Int64) // position, length
} derive(Eq, Show)

// Read trait for reading various data types from binary data

///|
priv trait Read {
  // Read int64 in little endian
  read_int64_le(Self) -> Int64 raise ReadError

  // Read int64 in big endian
  read_int64_be(Self) -> Int64 raise ReadError

  // Read int (32-bit) in little endian
  read_int_le(Self) -> Int raise ReadError

  // Read int (32-bit) in big endian
  read_int_be(Self) -> Int raise ReadError

  // Read short (16-bit) in little endian
  read_int16_le(Self) -> Int16 raise ReadError

  // Read short (16-bit) in big endian
  read_int16_be(Self) -> Int16 raise ReadError

  // Read uint64 in little endian
  read_uint64_le(Self) -> UInt64 raise ReadError

  // Read uint64 in big endian
  read_uint64_be(Self) -> UInt64 raise ReadError

  // Read uint (32-bit) in little endian
  read_uint_le(Self) -> UInt raise ReadError

  // Read uint (32-bit) in big endian
  read_uint_be(Self) -> UInt raise ReadError

  // Read unsigned short (16-bit) in little endian
  read_uint16_le(Self) -> UInt16 raise ReadError

  // Read unsigned short (16-bit) in big endian
  read_uint16_be(Self) -> UInt16 raise ReadError

  // Read bytes with specified length
  // If length is -1, read until end of stream
  read_bytes(Self, Int) -> Bytes raise ReadError

  // Read all remaining bytes until end of stream
  read_all_bytes(Self) -> Bytes raise ReadError
}

// Seek trait for positioning within the data stream

///|
priv trait Seek {
  // Seek to absolute position from start
  seek_from_start(Self, Int64) -> Int64 raise SeekError

  // Seek relative to current position
  seek_from_current(Self, Int64) -> Int64 raise SeekError

  // Seek relative to end
  seek_from_end(Self, Int64) -> Int64 raise SeekError

  // Get current position
  position(Self) -> Int64

  // Get total length/size
  length(Self) -> Int64

  // Get the remaining bytes
  remaining(Self) -> Int64
}

// BytesReader wraps a Bytes and provides Read/Seek functionality

///|
priv struct BytesReader {
  data : Bytes
  mut position : Int
}

// Constructor for BytesReader

///|
fn BytesReader::new(data : Bytes) -> BytesReader {
  { data, position: 0 }
}

// Helper function to read multiple bytes

///|
fn read_bytes_helper(
  self : BytesReader,
  count : Int
) -> @bytes.View raise ReadError {
  if self.position + count > self.data.length() {
    raise ReadError::BufferUnderflow(count)
  }
  let retval = self.data[self.position:self.position + count]
  self.position += count
  retval
}

// Implement Read trait for BytesReader

///|
impl Read for BytesReader with read_int64_le(self) -> Int64 raise ReadError {
  let bytes = self.read_bytes_helper(8)
  // Convert bytes to int64 (little endian)
  let b0 = bytes[0].to_int64() & 0xFFL
  let b1 = bytes[1].to_int64() & 0xFFL
  let b2 = bytes[2].to_int64() & 0xFFL
  let b3 = bytes[3].to_int64() & 0xFFL
  let b4 = bytes[4].to_int64() & 0xFFL
  let b5 = bytes[5].to_int64() & 0xFFL
  let b6 = bytes[6].to_int64() & 0xFFL
  let b7 = bytes[7].to_int64() & 0xFFL
  b0 |
  (b1 << 8) |
  (b2 << 16) |
  (b3 << 24) |
  (b4 << 32) |
  (b5 << 40) |
  (b6 << 48) |
  (b7 << 56)
}

///|
impl Read for BytesReader with read_int64_be(self) -> Int64 raise ReadError {
  let bytes = self.read_bytes_helper(8)
  // Convert bytes to int64 (big endian)
  let b0 = bytes[0].to_int64() & 0xFFL
  let b1 = bytes[1].to_int64() & 0xFFL
  let b2 = bytes[2].to_int64() & 0xFFL
  let b3 = bytes[3].to_int64() & 0xFFL
  let b4 = bytes[4].to_int64() & 0xFFL
  let b5 = bytes[5].to_int64() & 0xFFL
  let b6 = bytes[6].to_int64() & 0xFFL
  let b7 = bytes[7].to_int64() & 0xFFL
  (b0 << 56) |
  (b1 << 48) |
  (b2 << 40) |
  (b3 << 32) |
  (b4 << 24) |
  (b5 << 16) |
  (b6 << 8) |
  b7
}

///|
impl Read for BytesReader with read_int_le(self) -> Int raise ReadError {
  let bytes = self.read_bytes_helper(4)
  // Convert bytes to int (little endian)
  let b0 = bytes[0].to_int() & 0xFF
  let b1 = bytes[1].to_int() & 0xFF
  let b2 = bytes[2].to_int() & 0xFF
  let b3 = bytes[3].to_int() & 0xFF
  b0 | (b1 << 8) | (b2 << 16) | (b3 << 24)
}

///|
impl Read for BytesReader with read_int_be(self) -> Int raise ReadError {
  let bytes = self.read_bytes_helper(4)
  // Convert bytes to int (big endian)
  let b0 = bytes[0].to_int() & 0xFF
  let b1 = bytes[1].to_int() & 0xFF
  let b2 = bytes[2].to_int() & 0xFF
  let b3 = bytes[3].to_int() & 0xFF
  (b0 << 24) | (b1 << 16) | (b2 << 8) | b3
}

///|
impl Read for BytesReader with read_int16_le(self) -> Int16 raise ReadError {
  let bytes = self.read_bytes_helper(2)
  // Convert bytes to short (little endian)
  let b0 = bytes[0].to_int16() & 0xFF
  let b1 = bytes[1].to_int16() & 0xFF
  b0 | (b1 << 8)
}

///|
impl Read for BytesReader with read_int16_be(self) -> Int16 raise ReadError {
  let bytes = self.read_bytes_helper(2)
  // Convert bytes to short (big endian)
  let b0 = bytes[0].to_int16() & 0xFF
  let b1 = bytes[1].to_int16() & 0xFF
  (b0 << 8) | b1
}

///|
impl Read for BytesReader with read_uint64_le(self) -> UInt64 raise ReadError {
  let bytes = self.read_bytes_helper(8)
  // Convert bytes to uint64 (little endian)
  let b0 = bytes[0].to_uint64() & 0xFFUL
  let b1 = bytes[1].to_uint64() & 0xFFUL
  let b2 = bytes[2].to_uint64() & 0xFFUL
  let b3 = bytes[3].to_uint64() & 0xFFUL
  let b4 = bytes[4].to_uint64() & 0xFFUL
  let b5 = bytes[5].to_uint64() & 0xFFUL
  let b6 = bytes[6].to_uint64() & 0xFFUL
  let b7 = bytes[7].to_uint64() & 0xFFUL
  b0 |
  (b1 << 8) |
  (b2 << 16) |
  (b3 << 24) |
  (b4 << 32) |
  (b5 << 40) |
  (b6 << 48) |
  (b7 << 56)
}

///|
impl Read for BytesReader with read_uint64_be(self) -> UInt64 raise ReadError {
  let bytes = self.read_bytes_helper(8)
  // Convert bytes to uint64 (big endian)
  let b0 = bytes[0].to_uint64() & 0xFFUL
  let b1 = bytes[1].to_uint64() & 0xFFUL
  let b2 = bytes[2].to_uint64() & 0xFFUL
  let b3 = bytes[3].to_uint64() & 0xFFUL
  let b4 = bytes[4].to_uint64() & 0xFFUL
  let b5 = bytes[5].to_uint64() & 0xFFUL
  let b6 = bytes[6].to_uint64() & 0xFFUL
  let b7 = bytes[7].to_uint64() & 0xFFUL
  (b0 << 56) |
  (b1 << 48) |
  (b2 << 40) |
  (b3 << 32) |
  (b4 << 24) |
  (b5 << 16) |
  (b6 << 8) |
  b7
}

///|
impl Read for BytesReader with read_uint_le(self) -> UInt raise ReadError {
  let bytes = self.read_bytes_helper(4)
  // Convert bytes to uint (little endian)
  let b0 = bytes[0].to_uint() & 0xFFU
  let b1 = bytes[1].to_uint() & 0xFFU
  let b2 = bytes[2].to_uint() & 0xFFU
  let b3 = bytes[3].to_uint() & 0xFFU
  b0 | (b1 << 8) | (b2 << 16) | (b3 << 24)
}

///|
impl Read for BytesReader with read_uint_be(self) -> UInt raise ReadError {
  let bytes = self.read_bytes_helper(4)
  // Convert bytes to uint (big endian)
  let b0 = bytes[0].to_uint() & 0xFFU
  let b1 = bytes[1].to_uint() & 0xFFU
  let b2 = bytes[2].to_uint() & 0xFFU
  let b3 = bytes[3].to_uint() & 0xFFU
  (b0 << 24) | (b1 << 16) | (b2 << 8) | b3
}

///|
impl Read for BytesReader with read_uint16_le(self) -> UInt16 raise ReadError {
  let bytes = self.read_bytes_helper(2)
  // Convert bytes to unsigned short (little endian)
  let b0 = bytes[0].to_uint16() & 0xFF
  let b1 = bytes[1].to_uint16() & 0xFF
  b0 | (b1 << 8)
}

///|
impl Read for BytesReader with read_uint16_be(self) -> UInt16 raise ReadError {
  let bytes = self.read_bytes_helper(2)
  // Convert bytes to unsigned short (big endian)
  let b0 = bytes[0].to_uint16() & 0xFF
  let b1 = bytes[1].to_uint16() & 0xFF
  (b0 << 8) | b1
}

///|
impl Read for BytesReader with read_bytes(self, length : Int) -> Bytes raise ReadError {
  if length < 0 {
    raise ReadError::InvalidFormat("Negative length not allowed")
  }
  if self.position + length > self.data.length() {
    raise ReadError::BufferUnderflow(length)
  }
  let retval = self.data[self.position:self.position + length].to_bytes()
  self.position += length
  retval
}

///|
impl Read for BytesReader with read_all_bytes(self) -> Bytes raise ReadError {
  let remaining = self.data.length() - self.position
  if remaining <= 0 {
    raise ReadError::EndOfStream
  }
  self.position = self.data.length()
  self.data
}

// Implement Seek trait for BytesReader

///|
impl Seek for BytesReader with seek_from_start(self, offset : Int64) -> Int64 raise SeekError {
  let offset_int = offset.to_int()
  if offset < 0L || offset_int < 0 {
    raise SeekError::InvalidPosition(offset)
  }
  if offset_int > self.data.length() {
    raise SeekError::SeekOutOfBounds(offset, self.data.length().to_int64())
  }
  self.position = offset_int
  self.position.to_int64()
}

///|
impl Seek for BytesReader with seek_from_current(self, offset : Int64) -> Int64 raise SeekError {
  let new_pos = self.position.to_int64() + offset
  if new_pos < 0L {
    raise SeekError::InvalidPosition(new_pos)
  }
  let new_pos_int = new_pos.to_int()
  if new_pos_int < 0 || new_pos_int > self.data.length() {
    raise SeekError::SeekOutOfBounds(new_pos, self.data.length().to_int64())
  }
  self.position = new_pos_int
  self.position.to_int64()
}

///|
impl Seek for BytesReader with seek_from_end(self, offset : Int64) -> Int64 raise SeekError {
  let new_pos = self.data.length().to_int64() + offset
  if new_pos < 0L {
    raise SeekError::InvalidPosition(new_pos)
  }
  let new_pos_int = new_pos.to_int()
  if new_pos_int < 0 || new_pos_int > self.data.length() {
    raise SeekError::SeekOutOfBounds(new_pos, self.data.length().to_int64())
  }
  self.position = new_pos_int
  self.position.to_int64()
}

///|
impl Seek for BytesReader with position(self) -> Int64 {
  self.position.to_int64()
}

///|
impl Seek for BytesReader with length(self) -> Int64 {
  self.data.length().to_int64()
}

///|
impl Seek for BytesReader with remaining(self) -> Int64 {
  self.data.length().to_int64() - self.position.to_int64()
}
