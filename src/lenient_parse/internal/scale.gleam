import gleam/int
import gleam/order
import gleam/queue.{type Queue}
import gleam/result
import lenient_parse/internal/base_constants.{base_10}

pub fn queues(
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

      queues(whole_digits, fractional_digits, scale_factor - 1)
    }
    order.Lt -> {
      let #(whole_digit, whole_digits) =
        whole_digits
        |> queue.pop_back
        |> result.unwrap(#(0, whole_digits))

      let fractional_digits = fractional_digits |> queue.push_front(whole_digit)

      queues(whole_digits, fractional_digits, scale_factor + 1)
    }
  }
}

pub fn float(factor: Float, exponent: Int) {
  do_float(
    factor: factor,
    exponent: exponent,
    scale_factor: 1,
    exponent_is_positive: exponent >= 0,
  )
}

fn do_float(
  factor factor: Float,
  exponent exponent: Int,
  scale_factor scale_factor: Int,
  exponent_is_positive exponent_is_positive: Bool,
) -> Float {
  case int.compare(exponent, 0) {
    order.Eq -> {
      let scale_factor_float = scale_factor |> int.to_float
      case exponent_is_positive {
        True -> factor *. scale_factor_float
        False -> factor /. scale_factor_float
      }
    }
    order.Gt ->
      do_float(
        factor,
        exponent - 1,
        scale_factor * base_10,
        exponent_is_positive,
      )
    order.Lt ->
      do_float(
        factor,
        exponent + 1,
        scale_factor * base_10,
        exponent_is_positive,
      )
  }
}
