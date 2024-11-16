import gleam/queue
import lenient_parse/internal/parser.{digits_to_int, digits_to_int_with_base}
import startest/expect

pub fn digit_to_int_test() {
  [1, 2, 3] |> queue.from_list |> digits_to_int |> expect.to_equal(123)

  [0xa, 0xb, 0xc, 0xd, 0xe, 0xf]
  |> queue.from_list
  |> digits_to_int_with_base(base: 16)
  |> expect.to_equal(0xabcdef)
}
