priv trait ReadCString {
  read_cstring(Self, offset : Int) -> String raise @encoding.DecodingError
}

impl ReadCString for Bytes with read_cstring(self, offset : Int) -> String raise @encoding.DecodingError {
  let mut i = offset
  while i < self.length() {
    if self[i] == 0 {
      break
    }
    i += 1
  }
  let str = @encoding.decode(self[offset:i], encoding=UTF8)
  str
}