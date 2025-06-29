///|
suberror ReadOrSeekError {
  ReadError(ReadError)
  SeekError(SeekError)
} derive(Eq, Show)

///|
suberror ParseError {
  ReadingError(ReadOrSeekError)
  InvalidFormat(String)
} derive(Eq, Show)

///|
pub struct Terminal {
  name : String
  aliases : Array[String]
  bool_values : Array[BooleanAbility]
  num_values : Array[NumericAbility]
  str_values : Array[StringAbility]
  ext_bool_values : Array[Bool]
  ext_num_values : Array[Int]
  ext_str_values : Array[String]
  ext_names : Array[String]
} derive(Eq, Show, ToJson)

///|
pub fn Terminal::from_bytes(bytes : Bytes) -> Terminal raise ParseError {
  let reader = BytesReader::new(bytes)
  guard reader.length() >= 12 else {
    raise ParseError::InvalidFormat("Terminal data is too short")
  }
  let mut name = ""
  let aliases : Array[String] = []
  let bool_values : Array[BooleanAbility] = []
  let num_values : Array[NumericAbility] = []
  let str_values : Array[StringAbility] = []
  let ext_bool_values : Array[Bool] = []
  let ext_num_values : Array[Int] = []
  let ext_str_values : Array[String] = []
  let ext_names : Array[String] = []
  try {
    let magic = try? reader.read_bytes(2)
    let num_bytes_size = match magic {
      // 16-bit terminfo
      Ok([0x1A, 0x01]) => 2
      // 32-bit terminfo
      Ok([0x1E, 0x02]) => 4
      _ =>
        raise ParseError::InvalidFormat(
          "Invalid terminal magic: " + magic.to_string(),
        )
    }
    let name_length = reader.read_uint16_le()
    let bool_length = reader.read_uint16_le()
    let num_length = reader.read_uint16_le()
    let str_length = reader.read_uint16_le()
    let str_table_length = reader.read_uint16_le()
    // read name
    {
      let raw_name_bytes = reader.read_bytes(name_length.to_int())
      let raw_name_string = @encoding.decode(raw_name_bytes, encoding=UTF8)
      // remove the last \0
      let raw_name_string = raw_name_string.trim_end("\u{00}")
      let splited_names = raw_name_string.split("|"[:]).collect()
      for i, splited_name in splited_names.iter2() {
        if i == splited_names.length() - 1 {
          name = splited_name.to_string()
        } else {
          aliases.push(splited_name.to_string())
        }
      }
    }
    // read bool values
    {
      let raw_bool_bytes = reader.read_bytes(bool_length.to_int())
      for i, b in raw_bool_bytes.iter2() {
        // slient fail
        if i > all_boolean_abilities.length() {
          break
        }
        if b != 0 {
          bool_values.push(all_boolean_abilities[i])
        }
      }
    }
    // skip padding
    if (name_length + bool_length) % 2 != 0 && reader.remaining() > 0 {
      reader.read_bytes(1) |> ignore
    }
    // read numeric values
    for num_index in 0..<num_length.to_int() {
      if num_index > all_numeric_abilities.length() {
        break
      }
      let num_value = match num_bytes_size {
        2 => reader.read_int16_le().to_int()
        4 => reader.read_int_le()
        _ =>
          raise ParseError::InvalidFormat(
            "Invalid numeric bytes size: " + num_bytes_size.to_string(),
          )
      }
      if num_value != -1 {
        num_values.push(all_numeric_abilities[num_index](num_value))
      }
    }
    // read string values
    {
      // ignore the rest of the string values
      let std_str_length = @math.minimum(str_length.to_int(), all_string_abilities.length())
      let str_offsets: Array[Int] = Array::new(capacity=std_str_length)
      for i in 0..<std_str_length {
        str_offsets.push(reader.read_int16_le().to_int())
      }
      let tables = reader.read_bytes(str_table_length.to_int())
      for i in 0..<std_str_length {
        let str_offset = str_offsets[i]
        if str_offset > tables.length() {
          raise ParseError::InvalidFormat("String offset is out of range")
        }
        if str_offset == -1 {
          continue
        }
        let str_value = try? ReadCString::read_cstring(tables, str_offset)
        let str_value = str_value.map_err(e => ParseError::InvalidFormat(e.to_string())).unwrap_or_error()
        str_values.push(all_string_abilities[i](str_value))
      }
    }
    // skip padding
    if str_table_length % 2 != 0 && reader.remaining() > 0 {
      reader.read_bytes(1) |> ignore
    }
  } catch {
    ReadError(e) =>
      raise ParseError::ReadingError(ReadOrSeekError::ReadError(e))
    SeekError(e) =>
      raise ParseError::ReadingError(ReadOrSeekError::SeekError(e))
    ParseError::InvalidFormat(e) => raise ParseError::InvalidFormat(e)
    _ => raise ParseError::InvalidFormat("Unknown error")
  }
  Terminal::{
    name,
    aliases,
    bool_values,
    num_values,
    str_values,
    ext_bool_values,
    ext_num_values,
    ext_str_values,
    ext_names,
  }
}
