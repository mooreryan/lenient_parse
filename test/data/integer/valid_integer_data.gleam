import gleam/list
import test_data.{type TestData, TestData}

const valid_simple_integers: List(TestData(Int)) = [
  TestData(input: "1", output: Ok(1), python_output: Ok("1")),
  TestData(input: "+123", output: Ok(123), python_output: Ok("123")),
  TestData(input: "-123", output: Ok(-123), python_output: Ok("-123")),
  TestData(input: "0123", output: Ok(123), python_output: Ok("123")),
  TestData(input: "9876", output: Ok(9876), python_output: Ok("9876")),
  TestData(input: "-10", output: Ok(-10), python_output: Ok("-10")),
  TestData(input: "+0", output: Ok(0), python_output: Ok("0")),
  TestData(input: "42", output: Ok(42), python_output: Ok("42")),
  TestData(input: "-987654", output: Ok(-987_654), python_output: Ok("-987654")),
]

const valid_integers_with_underscores: List(TestData(Int)) = [
  TestData(input: "1_000", output: Ok(1000), python_output: Ok("1000")),
  TestData(
    input: "1_000_000",
    output: Ok(1_000_000),
    python_output: Ok("1000000"),
  ),
  TestData(
    input: "1_234_567_890",
    output: Ok(1_234_567_890),
    python_output: Ok("1234567890"),
  ),
  TestData(
    input: "-1_000_000",
    output: Ok(-1_000_000),
    python_output: Ok("-1000000"),
  ),
  TestData(
    input: "+1_234_567",
    output: Ok(1_234_567),
    python_output: Ok("1234567"),
  ),
  TestData(
    input: "9_876_543_210",
    output: Ok(9_876_543_210),
    python_output: Ok("9876543210"),
  ),
]

const valid_integers_with_whitespace: List(TestData(Int)) = [
  TestData(input: " +123 ", output: Ok(123), python_output: Ok("123")),
  TestData(input: " -123 ", output: Ok(-123), python_output: Ok("-123")),
  TestData(input: " 0123", output: Ok(123), python_output: Ok("123")),
  TestData(input: " 1 ", output: Ok(1), python_output: Ok("1")),
  TestData(input: "42 ", output: Ok(42), python_output: Ok("42")),
  TestData(input: " +0 ", output: Ok(0), python_output: Ok("0")),
  TestData(input: "  -987  ", output: Ok(-987), python_output: Ok("-987")),
  TestData(input: "\t123\t", output: Ok(123), python_output: Ok("123")),
  TestData(input: "\n456\n", output: Ok(456), python_output: Ok("456")),
]

pub fn data() -> List(TestData(Int)) {
  [
    valid_simple_integers,
    valid_integers_with_underscores,
    valid_integers_with_whitespace,
  ]
  |> list.flatten
}
