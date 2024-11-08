import gleam/list
import parse_error.{
  EmptyString, InvalidDecimalPosition, InvalidExponentSymbolPosition,
  InvalidUnderscorePosition, UnknownCharacter, WhitespaceOnlyString,
}
import test_data.{type TestData, TestData}

const invalid_empty_or_whitespace: List(TestData(Float)) = [
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
    input: " \t\n\r\f ",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  TestData(
    input: "  \t  ",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
]

const invalid_decimal_positions: List(TestData(Float)) = [
  TestData(
    input: "..1",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1..",
    output: Error(InvalidDecimalPosition(2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: ".1.",
    output: Error(InvalidDecimalPosition(2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: ".",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "..",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: " .",
    output: Error(InvalidDecimalPosition(1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1.2.3",
    output: Error(InvalidDecimalPosition(3)),
    python_output: Error(Nil),
  ),
  TestData(
    input: ".1.2",
    output: Error(InvalidDecimalPosition(2)),
    python_output: Error(Nil),
  ),
]

const invalid_underscore_positions: List(TestData(Float)) = [
  TestData(
    input: "_.",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "._",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1_.000",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1._000",
    output: Error(InvalidUnderscorePosition(2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "_1000.0",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1000.0_",
    output: Error(InvalidUnderscorePosition(6)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1000._0",
    output: Error(InvalidUnderscorePosition(5)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1000_.0",
    output: Error(InvalidUnderscorePosition(4)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1000_.",
    output: Error(InvalidUnderscorePosition(4)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1_000__000.0",
    output: Error(InvalidUnderscorePosition(6)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "_1_000.0",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1_000.0_",
    output: Error(InvalidUnderscorePosition(7)),
    python_output: Error(Nil),
  ),
]

const invalid_characters: List(TestData(Float)) = [
  TestData(
    input: ". ",
    output: Error(UnknownCharacter(" ", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "abc",
    output: Error(UnknownCharacter("a", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "100.00c01",
    output: Error(UnknownCharacter("c", 6)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "3.14f",
    output: Error(UnknownCharacter("f", 4)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "$100.00",
    output: Error(UnknownCharacter("$", 0)),
    python_output: Error(Nil),
  ),
]

const invalid_exponent_positions: List(TestData(Float)) = [
  TestData(
    input: "e",
    output: Error(InvalidExponentSymbolPosition("e", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "E",
    output: Error(InvalidExponentSymbolPosition("E", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "e4",
    output: Error(InvalidExponentSymbolPosition("e", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "E4",
    output: Error(InvalidExponentSymbolPosition("E", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "4e",
    output: Error(InvalidExponentSymbolPosition("e", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "4E",
    output: Error(InvalidExponentSymbolPosition("E", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "4.e",
    output: Error(InvalidExponentSymbolPosition("e", 2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "4.E",
    output: Error(InvalidExponentSymbolPosition("E", 2)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "4e.",
    output: Error(InvalidExponentSymbolPosition("e", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "4E.",
    output: Error(InvalidExponentSymbolPosition("E", 1)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "E4.0",
    output: Error(InvalidExponentSymbolPosition("E", 0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "4.0E",
    output: Error(InvalidExponentSymbolPosition("E", 3)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1_234.e-4e",
    output: Error(InvalidExponentSymbolPosition("e", 9)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1e2e3",
    output: Error(InvalidExponentSymbolPosition("e", 3)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1E2E3",
    output: Error(InvalidExponentSymbolPosition("E", 3)),
    python_output: Error(Nil),
  ),
]

const invalid_mixed: List(TestData(Float)) = [
  TestData(
    input: "4.0E_2",
    output: Error(InvalidUnderscorePosition(4)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1.2e_3",
    output: Error(InvalidUnderscorePosition(4)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "4.0_E2",
    output: Error(InvalidUnderscorePosition(3)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1_234.e-4.3",
    output: Error(InvalidDecimalPosition(9)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "_1.2e3",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "1.2e3_",
    output: Error(InvalidUnderscorePosition(5)),
    python_output: Error(Nil),
  ),
  TestData(
    input: ".e",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: ".E",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: ".e4",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: ".E4",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  TestData(
    input: " 4.0E",
    output: Error(InvalidExponentSymbolPosition("E", 4)),
    python_output: Error(Nil),
  ),
  TestData(
    input: "4.0E ",
    output: Error(UnknownCharacter(" ", 4)),
    python_output: Error(Nil),
  ),
  TestData(
    input: " 4.0E ",
    output: Error(UnknownCharacter(" ", 5)),
    python_output: Error(Nil),
  ),
]

pub fn data() -> List(TestData(Float)) {
  [
    invalid_empty_or_whitespace,
    invalid_decimal_positions,
    invalid_underscore_positions,
    invalid_characters,
    invalid_exponent_positions,
    invalid_mixed,
  ]
  |> list.flatten
}
