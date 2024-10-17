import gleam/list
import helpers.{into_printable_text}
import lenient_parse/internal/coerce.{coerce_into_valid_number_string}
import parse_error.{
  InvalidCharacter, InvalidDecimalPosition, InvalidUnderscorePosition,
  SignAtInvalidPosition, WhitespaceOnlyOrEmptyString,
}
import startest.{describe, it}
import startest/expect

pub fn coerce_into_valid_number_string_tests() {
  describe("coerce_into_valid_number_string_test", [
    describe(
      "should_coerce",
      [
        #("0", "0"),
        #("0.0", "0.0"),
        #(".1", "0.1"),
        #("1.", "1.0"),
        #("+1000", "+1000"),
        #("-1000", "-1000"),
        #(" 1000 ", "1000"),
        #(" -1000 ", "-1000"),
        #("+1.0", "+1.0"),
        #("-1.0", "-1.0"),
        #("1_000", "1000"),
        #("1_000_000", "1000000"),
        #("1_000_000.0", "1000000.0"),
        #("1_000_000.000_1", "1000000.0001"),
        #("1000.000_000", "1000.000000"),
      ]
        |> list.map(fn(pair) {
          let #(input, output) = pair
          use <- it("\"" <> input <> "\" -> \"" <> output <> "\"")

          input
          |> coerce_into_valid_number_string
          |> expect.to_equal(Ok(output))
        }),
    ),
    describe(
      "should_not_coerce",
      [
        ["", " ", "\t", "\n", "\r", "\f", " \t\n\r\f "]
          |> list.map(fn(value) { #(value, WhitespaceOnlyOrEmptyString) }),
        [
          "_", "_1000", "1000_", "+_1000", "-_1000", "1__000", "1_.000",
          "1._000", "_1000.0", "1000.0_", "1000._0", "1000_.0", "1000_.",
        ]
          |> list.map(fn(value) { #(value, InvalidUnderscorePosition) }),
        [#("a", "a"), #("1b1", "b"), #("100.00c01", "c"), #("1 1", " ")]
          |> list.map(fn(pair) { #(pair.0, InvalidCharacter(pair.1)) }),
        [#("1+", "+"), #("1-", "-"), #("1+1", "+"), #("1-1", "-")]
          |> list.map(fn(pair) { #(pair.0, SignAtInvalidPosition(pair.1)) }),
        [".", "..", "0.0.", ".0.0"]
          |> list.map(fn(value) { #(value, InvalidDecimalPosition) }),
      ]
        |> list.concat
        |> list.map(fn(pair) {
          let #(input, error) = pair
          let printable_text = input |> into_printable_text
          let error_text = error |> parse_error.to_string

          use <- it("\"" <> printable_text <> "\" -> " <> error_text)

          input
          |> coerce_into_valid_number_string
          |> expect.to_equal(Error(error))
        }),
    ),
  ])
}
