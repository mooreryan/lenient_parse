import gleam/int
import gleam/order
import gleam/queue.{type Queue}
import gleam/result

pub fn by_10(
  whole_digits: Queue(Int),
  fractional_digits: Queue(Int),
  scale_factor: Int,
) -> #(Queue(Int), Queue(Int)) {
  case int.compare(scale_factor, 0) {
    order.Eq -> #(whole_digits, fractional_digits)
    order.Gt -> {
      let #(fractional_digit, fractional_digits) =
        fractional_digits
        |> queue.pop_front
        |> result.unwrap(#(0, fractional_digits))

      let whole_digits = whole_digits |> queue.push_back(fractional_digit)

      by_10(whole_digits, fractional_digits, scale_factor - 1)
    }
    order.Lt -> {
      let #(whole_digit, whole_digits) =
        whole_digits
        |> queue.pop_back
        |> result.unwrap(#(0, whole_digits))

      let fractional_digits = fractional_digits |> queue.push_front(whole_digit)

      by_10(whole_digits, fractional_digits, scale_factor + 1)
    }
  }
}
