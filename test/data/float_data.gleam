import parse_error.{
  type ParseError, EmptyString, InvalidDecimalPosition,
  InvalidUnderscorePosition, UnknownCharacter, WhitespaceOnlyString,
}

pub type FloatTestData {
  FloatTestData(
    input: String,
    output: Result(Float, ParseError),
    python_output: Result(String, Nil),
  )
}

pub const data = [
  FloatTestData(input: "1.001", output: Ok(1.001), python_output: Ok("1.001")),
  FloatTestData(input: "1.00", output: Ok(1.0), python_output: Ok("1.0")),
  FloatTestData(input: "1.0", output: Ok(1.0), python_output: Ok("1.0")),
  FloatTestData(input: "0.1", output: Ok(0.1), python_output: Ok("0.1")),
  FloatTestData(input: "+1.0", output: Ok(1.0), python_output: Ok("1.0")),
  FloatTestData(input: "-1.0", output: Ok(-1.0), python_output: Ok("-1.0")),
  FloatTestData(
    input: "+123.321",
    output: Ok(123.321),
    python_output: Ok("123.321"),
  ),
  FloatTestData(
    input: "-123.321",
    output: Ok(-123.321),
    python_output: Ok("-123.321"),
  ), FloatTestData(input: "1", output: Ok(1.0), python_output: Ok("1.0")),
  FloatTestData(input: "1.", output: Ok(1.0), python_output: Ok("1.0")),
  FloatTestData(input: ".1", output: Ok(0.1), python_output: Ok("0.1")),
  FloatTestData(
    input: "1_000_000.0",
    output: Ok(1_000_000.0),
    python_output: Ok("1000000.0"),
  ),
  FloatTestData(
    input: "1_000_000.000_1",
    output: Ok(1_000_000.0001),
    python_output: Ok("1000000.0001"),
  ),
  FloatTestData(
    input: "1000.000_000",
    output: Ok(1000.0),
    python_output: Ok("1000.0"),
  ),
  FloatTestData(
    input: "1000.000_000",
    output: Ok(1000.0),
    python_output: Ok("1000.0"),
  ), FloatTestData(input: " 1 ", output: Ok(1.0), python_output: Ok("1.0")),
  FloatTestData(input: " 1.0 ", output: Ok(1.0), python_output: Ok("1.0")),
  FloatTestData(
    input: " 1000 ",
    output: Ok(1000.0),
    python_output: Ok("1000.0"),
  ),
  FloatTestData(
    input: "",
    output: Error(EmptyString),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: " ",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "\t",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "\n",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "\r",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "\f",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "\r\n",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: " \t\n\r\f ",
    output: Error(WhitespaceOnlyString),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "..1",
    output: Error(InvalidDecimalPosition(1)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "1..",
    output: Error(InvalidDecimalPosition(2)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: ".1.",
    output: Error(InvalidDecimalPosition(2)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: ".",
    output: Error(InvalidDecimalPosition(0)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "..",
    output: Error(InvalidDecimalPosition(1)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: " .",
    output: Error(InvalidDecimalPosition(1)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: ". ",
    output: Error(UnknownCharacter(" ", 1)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "_.",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "._",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "1_.000",
    output: Error(InvalidUnderscorePosition(1)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "1._000",
    output: Error(InvalidUnderscorePosition(2)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "_1000.0",
    output: Error(InvalidUnderscorePosition(0)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "1000.0_",
    output: Error(InvalidUnderscorePosition(6)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "1000._0",
    output: Error(InvalidUnderscorePosition(5)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "1000_.0",
    output: Error(InvalidUnderscorePosition(4)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "1000_.",
    output: Error(InvalidUnderscorePosition(4)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "1_000__000.0",
    output: Error(InvalidUnderscorePosition(6)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "abc",
    output: Error(UnknownCharacter("a", 0)),
    python_output: Error(Nil),
  ),
  FloatTestData(
    input: "100.00c01",
    output: Error(UnknownCharacter("c", 6)),
    python_output: Error(Nil),
  ),
]
