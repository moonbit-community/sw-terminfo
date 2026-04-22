// Error types for reading and seeking operations

///|
priv suberror ReadError {
  EndOfStream
  InvalidFormat(String)
  BufferUnderflow(Int) // expected bytes
} derive(Eq, Debug)

// Read trait for reading various data types from binary data

///|
priv trait Read {
  // Read int (32-bit) in little endian
  read_int_le(Self) -> Int raise ReadError

  // Read short (16-bit) in little endian
  read_int16_le(Self) -> Int16 raise ReadError

  // Read unsigned short (16-bit) in little endian
  read_uint16_le(Self) -> UInt16 raise ReadError

  // Read bytes with specified length
  // If length is -1, read until end of stream
  read_bytes(Self, Int) -> Bytes raise ReadError
}

// Seek trait for positioning within the data stream

///|
priv trait Seek {
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
fn BytesReader::read_bytes_helper(self : BytesReader, count : Int) -> BytesView raise ReadError {
  if self.position + count > self.data.length() {
    raise ReadError::BufferUnderflow(count)
  }
  let retval = self.data[self.position:self.position + count]
  self.position += count
  retval
}

// Implement Read trait for BytesReader

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

impl Read for BytesReader with read_int16_le(self) -> Int16 raise ReadError {
  let bytes = self.read_bytes_helper(2)
  // Convert bytes to short (little endian)
  let b0 = Int16::from_byte(bytes[0]) & 0xFF
  let b1 = Int16::from_byte(bytes[1]) & 0xFF
  b0 | (b1 << 8)
}

impl Read for BytesReader with read_uint16_le(self) -> UInt16 raise ReadError {
  let bytes = self.read_bytes_helper(2)
  // Convert bytes to unsigned short (little endian)
  let b0 = bytes[0].to_uint16() & 0xFF
  let b1 = bytes[1].to_uint16() & 0xFF
  b0 | (b1 << 8)
}

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

// Implement Seek trait for BytesReader

///|
impl Seek for BytesReader with length(self) -> Int64 {
  self.data.length().to_int64()
}

///|
impl Seek for BytesReader with remaining(self) -> Int64 {
  self.data.length().to_int64() - self.position.to_int64()
}
