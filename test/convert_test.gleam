import lenient_parse/internal/convert.{digits_to_int_from_list}
import startest/expect

pub fn digit_to_int_test() {
  [1, 2, 3]
  |> digits_to_int_from_list(10)
  |> expect.to_equal(123)

  [0xa, 0xb, 0xc, 0xd, 0xe, 0xf]
  |> digits_to_int_from_list(base: 16)
  |> expect.to_equal(0xabcdef)
}
