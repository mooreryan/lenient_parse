import data
import gleam/float
import gleam/io
import gleam/list
import helpers
import lenient_parse
import parse_error
import python_floatvalue_grammar
import startest.{describe, it}
import startest/expect

pub fn to_float_tests() {
  describe(
    "float_test",
    data.float_test_data()
      |> list.map(fn(data) {
        let input = data.input
        let input_printable_text = input |> helpers.to_printable_text
        let expected_program_output = data.expected_program_output

        let message = case expected_program_output {
          Ok(output) -> {
            "should_parse: \""
            <> input_printable_text
            <> "\" -> "
            <> output |> float.to_string
          }
          Error(error) -> {
            let error_string = error |> helpers.error_to_string
            "should_not_parse: \""
            <> input_printable_text
            <> "\" -> \""
            <> error_string
            <> "\""
          }
        }

        use <- it(message)

        input
        |> lenient_parse.to_float
        |> expect.to_equal(expected_program_output)
      }),
  )
}

import qcheck

pub fn small_positive_or_zero_int__test() {
  let config = qcheck.default_config() |> qcheck.with_test_count(100)
  use float_string <- qcheck.run_result(
    config,
    python_floatvalue_grammar.finite_floatvalue_in_whitespace(),
  )
  io.debug(float_string)
  case lenient_parse.to_float(float_string) {
    Ok(x) -> Ok(x)
    Error(parse_error.OutOfFloatRange(_)) -> Ok(0.0)
    Error(error) -> Error(error)
  }
}
