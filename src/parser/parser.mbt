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
  ext_bool_values : Map[String, Bool]
  ext_num_values : Map[String, Int]
  ext_str_values : Map[String, String]
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
  let ext_bool_values : Map[String, Bool] = Map::new()
  let ext_num_values : Map[String, Int] = Map::new()
  let ext_str_values : Map[String, String] = Map::new()
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
      let std_str_length = @cmp.minimum(str_length.to_int(), all_string_abilities.length())
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
    // read extensions if available (need at least 10 bytes for extension header)
    if reader.remaining() >= 10 {
      let ext_bool_length = reader.read_uint16_le()
      let ext_num_length = reader.read_uint16_le()
      let ext_str_length = reader.read_uint16_le()
      let ext_offset_length = reader.read_uint16_le() // offset table length for names
      let ext_table_length = reader.read_uint16_le() // string table length
      
      // Calculate total extension names count
      let ext_all_length = ext_bool_length.to_int() + ext_num_length.to_int() + ext_str_length.to_int()
      
      // Validate extension sizes (unibilium uses MAX15BITS = 0x7fff)
      if ext_bool_length <= 0x7fff && ext_num_length <= 0x7fff && 
         ext_str_length <= 0x7fff && ext_offset_length <= 0x7fff && 
         ext_table_length <= 0x7fff {
        
        // Calculate required bytes for extension section
        let ext_required_bytes = ext_bool_length.to_int() +
          (if ext_bool_length % 2 != 0 { 1 } else { 0 }) + // padding
          ext_num_length.to_int() * num_bytes_size +
          ext_str_length.to_int() * 2 + // string offsets
          ext_all_length * 2 + // name offsets  
          ext_table_length.to_int()
        
        if reader.remaining() >= ext_required_bytes.to_int64() {
          // read extended boolean values (will be paired with names later)
          let ext_bool_data: Array[Bool] = []
          if ext_bool_length > 0 {
            let raw_ext_bool_bytes = reader.read_bytes(ext_bool_length.to_int())
            for b in raw_ext_bool_bytes {
              ext_bool_data.push(b != 0)
            }
          }
          
          // skip padding after extended booleans
          if ext_bool_length % 2 != 0 {
            reader.read_bytes(1) |> ignore
          }
          
          // read extended numeric values (will be paired with names later)
          let ext_num_data: Array[Int] = []
          if ext_num_length > 0 {
            for _ in 0..<ext_num_length.to_int() {
              let num_value = match num_bytes_size {
                2 => {
                  let raw_val = reader.read_int16_le().to_int()
                  if raw_val > 0x7fff { -1 } else { raw_val }
                }
                4 => {
                  let raw_val = reader.read_int_le()
                  if raw_val > 0x7fffffff { -1 } else { raw_val }
                }
                _ =>
                  raise ParseError::InvalidFormat(
                    "Invalid numeric bytes size in extensions: " + num_bytes_size.to_string(),
                  )
              }
              ext_num_data.push(num_value)
            }
          }
          
          // read extended string offsets
          let ext_str_offsets: Array[Int] = []
          if ext_str_length > 0 {
            for _ in 0..<ext_str_length.to_int() {
              ext_str_offsets.push(reader.read_int16_le().to_int())
            }
          }
          
          // read extended name offsets  
          let ext_name_offsets: Array[Int] = []
          if ext_all_length > 0 {
            for _ in 0..<ext_all_length {
              ext_name_offsets.push(reader.read_int16_le().to_int())
            }
          }
          
          // read the extension string/name table
          let ext_table = if ext_table_length > 0 {
            reader.read_bytes(ext_table_length.to_int())
          } else {
            Bytes::new(0)
          }
          
          // Calculate where name section starts (after all strings)
          // Following unibilium's logic: strings are placed first, then names
          let mut s_sum = 0
          let ext_str_data: Array[String] = []
          
          // First pass: calculate total string space and collect strings
          for ext_str_offset in ext_str_offsets {
            if ext_str_offset < 0 || ext_str_offset >= ext_table.length() {
              ext_str_data.push("")
            } else {
              let ext_str_result = try? ReadCString::read_cstring(ext_table, ext_str_offset)
              match ext_str_result {
                Ok(ext_str_value) => {
                  ext_str_data.push(ext_str_value)
                  s_sum += ext_str_value.length() + 1 // +1 for null terminator
                }
                Err(_) => ext_str_data.push("")
              }
            }
          }
          
          // collect extended names (from the name section which starts after strings)
          // Names are located in the second part of the table, starting at s_sum
          let ext_name_data: Array[String] = []
          for ext_name_offset in ext_name_offsets {
            let adjusted_offset = s_sum + ext_name_offset
            if ext_name_offset < 0 || adjusted_offset >= ext_table.length() {
              ext_name_data.push("")
            } else {
              let ext_name_result = try? ReadCString::read_cstring(ext_table, adjusted_offset)
              match ext_name_result {
                Ok(ext_name_value) => ext_name_data.push(ext_name_value)
                Err(_) => ext_name_data.push("")
              }
            }
          }
          
          // Now pair the names with their values and populate the maps
          // First ext_bool_length names correspond to boolean values
          for i in 0..<ext_bool_data.length() {
            if i < ext_name_data.length() {
              let name = ext_name_data[i]
              let value = ext_bool_data[i]
              ext_bool_values[name] = value
            }
          }
          
          // Next ext_num_length names correspond to numeric values  
          let num_start = ext_bool_length.to_int()
          for i in 0..<ext_num_data.length() {
            let name_idx = num_start + i
            if name_idx < ext_name_data.length() {
              let name = ext_name_data[name_idx]
              let value = ext_num_data[i]
              ext_num_values[name] = value
            }
          }
          
          // Finally ext_str_length names correspond to string values
          let str_start = num_start + ext_num_length.to_int()
          for i in 0..<ext_str_data.length() {
            let name_idx = str_start + i
            if name_idx < ext_name_data.length() {
              let name = ext_name_data[name_idx]
              let value = ext_str_data[i]
              ext_str_values[name] = value
            }
          }
        }
      }
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
  }
}
