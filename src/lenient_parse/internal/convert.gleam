import gleam/list
import gleam/queue.{type Queue}
import lenient_parse/internal/base_constants.{base_10}

pub fn digits_to_int(digits digits: Queue(Int)) -> Int {
  digits_to_int_with_base(digits: digits, base: base_10)
}

pub fn digits_to_int_with_base(digits digits: Queue(Int), base base: Int) -> Int {
  digits |> queue.to_list |> digits_to_int_from_list(base)
}

pub fn digits_to_int_from_list(digits digits: List(Int), base base: Int) -> Int {
  digits |> list.fold(0, fn(acc, digit) { acc * base + digit })
}
