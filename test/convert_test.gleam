import lenient_parse/internal/base_constants.{base_10, base_16, base_2, base_8}
import lenient_parse/internal/convert.{digits_to_int_from_list}
import startest/expect

pub fn digits_to_int_test() {
  [1, 2, 3]
  |> digits_to_int_from_list(base_10)
  |> expect.to_equal(123)

  [1, 0, 1]
  |> digits_to_int_from_list(base_2)
  |> expect.to_equal(0b101)

  [0o1, 0o2, 0o7]
  |> digits_to_int_from_list(base_8)
  |> expect.to_equal(0o127)

  [0xa, 0xb, 0xc, 0xd, 0xe, 0xf]
  |> digits_to_int_from_list(base_16)
  |> expect.to_equal(0xabcdef)
}
