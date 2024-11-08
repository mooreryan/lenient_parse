import gleam/list
import parse_error.{
  EmptyString, InvalidDigitPosition, InvalidSignPosition,
  InvalidUnderscorePosition, UnknownCharacter, WhitespaceOnlyString,
}
import test_data.{type TestData, TestData}

const invalid_empty_or_whitespace: List(TestData(Int)) = [
  TestData(input: "", output: Error(EmptyString), python_output: Error(Nil)),
  TestData(
    input: " ",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  TestData(
    input: "\t",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  TestData(
    input: "\n",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  TestData(
    input: "\r",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  TestData(
    input: "\f",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  TestData(
    input: "\r\n",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  TestData(
    input: " \t\n\r\f\r\n ",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  TestData(
    input: "   ",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
]

const invalid_underscore_positions: List(TestData(Int)) = [
  TestData(
    input: "_",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "_1000",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1000_",
    output: Error(InvalidUnderscorePosition(4)),
    python_output: Error(Nil),
  ),
  TestData(
    input: " _1000",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1000_ ",
    output: Error(InvalidUnderscorePosition(4)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "+_1000",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "-_1000",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1__000",
    output: Error(InvalidUnderscorePosition(2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1_000__000",
    output: Error(InvalidUnderscorePosition(6)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "_1_000",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1_000_",
    output: Error(InvalidUnderscorePosition(5)),
    python_output: Error(Nil),
  ),
]

const invalid_characters: List(TestData(Int)) = [
  TestData(
    input: "a",
    output: Error(UnknownCharacter("a", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1b1",
    output: Error(UnknownCharacter("b", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "+ 1",
    output: Error(UnknownCharacter(" ", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: ".",
    output: Error(UnknownCharacter(".", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "..",
    output: Error(UnknownCharacter(".", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "0.0.",
    output: Error(UnknownCharacter(".", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: ".0.0",
    output: Error(UnknownCharacter(".", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1.",
    output: Error(UnknownCharacter(".", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1.0",
    output: Error(UnknownCharacter(".", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "abc",
    output: Error(UnknownCharacter("a", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "e",
    output: Error(UnknownCharacter("e", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "E",
    output: Error(UnknownCharacter("E", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "e13",
    output: Error(UnknownCharacter("e", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1e3",
    output: Error(UnknownCharacter("e", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "13e",
    output: Error(UnknownCharacter("e", 2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "E13",
    output: Error(UnknownCharacter("E", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1E3",
    output: Error(UnknownCharacter("E", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "13E",
    output: Error(UnknownCharacter("E", 2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1$",
    output: Error(UnknownCharacter("$", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "#123",
    output: Error(UnknownCharacter("#", 0)),
    python_output: Error(Nil),
  ),
]

const invalid_digit_positions: List(TestData(Int)) = [
  TestData(
    input: "1 1",
    output: Error(InvalidDigitPosition("1", 2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: " 12 34 ",
    output: Error(InvalidDigitPosition("3", 4)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1 2 3",
    output: Error(InvalidDigitPosition("2", 2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "123 456",
    output: Error(InvalidDigitPosition("4", 4)),
    python_output: Error(Nil),
  ),
]

const invalid_sign_positions: List(TestData(Int)) = [
  TestData(
    input: "1+",
    output: Error(InvalidSignPosition("+", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1-",
    output: Error(InvalidSignPosition("-", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1+1",
    output: Error(InvalidSignPosition("+", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1-1",
    output: Error(InvalidSignPosition("-", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "++1",
    output: Error(InvalidSignPosition("+", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "--1",
    output: Error(InvalidSignPosition("-", 1)),
    python_output: Error(Nil),
  ),
]

const invalid_mixed: List(TestData(Int)) = [
  TestData(
    input: "e_1_3",
    output: Error(UnknownCharacter("e", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1_3_e",
    output: Error(InvalidUnderscorePosition(3)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1._3_e",
    output: Error(UnknownCharacter(".", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1+._3_e",
    output: Error(InvalidSignPosition("+", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1 1+._3_e",
    output: Error(InvalidDigitPosition("1", 2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1_a_2",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "+1.2_3",
    output: Error(UnknownCharacter(".", 2)),
    python_output: Error(Nil),
  ),
]

pub fn data() -> List(TestData(Int)) {
  [
    invalid_empty_or_whitespace,
    invalid_underscore_positions,
    invalid_characters,
    invalid_digit_positions,
    invalid_sign_positions,
    invalid_mixed,
  ]
  |> list.flatten
}
