import lenient_parse
import startest/expect

pub fn is_valid_number_string_true_test() {
  lenient_parse.is_valid_number_string("0") |> expect.to_be_true
  lenient_parse.is_valid_number_string("0.0") |> expect.to_be_true
  lenient_parse.is_valid_number_string("0.0.") |> expect.to_be_false
  lenient_parse.is_valid_number_string("1_000") |> expect.to_be_true
  lenient_parse.is_valid_number_string("1000.000_000")
  |> expect.to_be_true
  lenient_parse.is_valid_number_string("+1000") |> expect.to_be_true
  lenient_parse.is_valid_number_string("-1000") |> expect.to_be_true

  lenient_parse.is_valid_number_string(" 1000 ") |> expect.to_be_true
  lenient_parse.is_valid_number_string(" -1000 ") |> expect.to_be_true
}

pub fn is_valid_number_string_false_test() {
  lenient_parse.is_valid_number_string("a") |> expect.to_be_false
  lenient_parse.is_valid_number_string("1__000") |> expect.to_be_false
  lenient_parse.is_valid_number_string("1000_") |> expect.to_be_false
  lenient_parse.is_valid_number_string("_1000") |> expect.to_be_false
  lenient_parse.is_valid_number_string("1000_.") |> expect.to_be_false
  lenient_parse.is_valid_number_string("1000_.0") |> expect.to_be_false
  lenient_parse.is_valid_number_string("1000._0") |> expect.to_be_false
  lenient_parse.is_valid_number_string("1000.0_") |> expect.to_be_false
  lenient_parse.is_valid_number_string("_1000.0") |> expect.to_be_false
  lenient_parse.is_valid_number_string("_") |> expect.to_be_false
}
