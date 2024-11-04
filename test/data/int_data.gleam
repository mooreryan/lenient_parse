import parse_error.{
  type ParseError, EmptyString, InvalidDecimalPosition, InvalidDigitPosition,
  InvalidSignPosition, InvalidUnderscorePosition, UnknownCharacter,
  WhitespaceOnlyString,
}

pub type IntegerTestData {
  IntegerTestData(
    input: String,
    output: Result(Int, ParseError),
    python_output: Result(String, Nil),
  )
}

pub const data = [
  IntegerTestData(input: "1", output: Ok(1), python_output: Ok("1")),
  IntegerTestData(input: "+123", output: Ok(123), python_output: Ok("123")),
  IntegerTestData(input: " +123 ", output: Ok(123), python_output: Ok("123")),
  IntegerTestData(input: " -123 ", output: Ok(-123), python_output: Ok("-123")),
  IntegerTestData(input: "0123", output: Ok(123), python_output: Ok("123")),
  IntegerTestData(input: " 0123", output: Ok(123), python_output: Ok("123")),
  IntegerTestData(input: "-123", output: Ok(-123), python_output: Ok("-123")),
  IntegerTestData(input: "1_000", output: Ok(1000), python_output: Ok("1000")),
  IntegerTestData(
    input: "1_000_000",
    output: Ok(1_000_000),
    python_output: Ok("1000000"),
  ), IntegerTestData(input: " 1 ", output: Ok(1), python_output: Ok("1")),
  IntegerTestData(
    input: "",
    output: Error(EmptyString),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: " ",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "\t",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "\n",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "\r",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "\f",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "\r\n",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: " \t\n\r\f\r\n ",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "_",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "_1000",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1000_",
    output: Error(InvalidUnderscorePosition(4)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: " _1000",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1000_ ",
    output: Error(InvalidUnderscorePosition(4)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "+_1000",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "-_1000",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1__000",
    output: Error(InvalidUnderscorePosition(2)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1_000__000",
    output: Error(InvalidUnderscorePosition(6)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "a",
    output: Error(UnknownCharacter("a", 0)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1b1",
    output: Error(UnknownCharacter("b", 1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "+ 1",
    output: Error(UnknownCharacter(" ", 1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1 1",
    output: Error(InvalidDigitPosition("1", 2)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: " 12 34 ",
    output: Error(InvalidDigitPosition("3", 4)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "abc",
    output: Error(UnknownCharacter("a", 0)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1+",
    output: Error(InvalidSignPosition("+", 1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1-",
    output: Error(InvalidSignPosition("-", 1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1+1",
    output: Error(InvalidSignPosition("+", 1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1-1",
    output: Error(InvalidSignPosition("-", 1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: ".",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "..",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "0.0.",
    output: Error(InvalidDecimalPosition(1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: ".0.0",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1.",
    output: Error(InvalidDecimalPosition(1)),
    python_output: Error(Nil),
  ),
  IntegerTestData(
    input: "1.0",
    output: Error(InvalidDecimalPosition(1)),
    python_output: Error(Nil),
  ),
]
