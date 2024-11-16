import gleam/bool
import gleam/int
import gleam/queue.{type Queue}
import lenient_parse/internal/convert
import lenient_parse/internal/scale

pub fn float_value(
  is_positive is_positive: Bool,
  whole_digits whole_digits: Queue(Int),
  fractional_digits fractional_digits: Queue(Int),
  scale_factor scale_factor: Int,
) -> Float {
  let #(whole_digits, fractional_digits) =
    scale.queues(whole_digits, fractional_digits, scale_factor)
  let fractional_digits_length = fractional_digits |> queue.length
  let #(all_digits, _) =
    scale.queues(whole_digits, fractional_digits, fractional_digits_length)
  let scaled_float_value =
    all_digits
    |> convert.digits_to_int
    |> int.to_float
    |> scale.float(-fractional_digits_length)
  use <- bool.guard(is_positive, scaled_float_value)
  scaled_float_value *. -1.0
}
