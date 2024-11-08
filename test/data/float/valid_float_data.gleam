import gleam/list
import test_data.{type TestData, TestData}

const valid_simple_floats: List(TestData(Float)) = [
  TestData(input: "1.001", output: Ok(1.001), python_output: Ok("1.001")),
  TestData(input: "1.00", output: Ok(1.0), python_output: Ok("1.0")),
  TestData(input: "1.0", output: Ok(1.0), python_output: Ok("1.0")),
  TestData(input: "0.1", output: Ok(0.1), python_output: Ok("0.1")),
  TestData(input: "+1.0", output: Ok(1.0), python_output: Ok("1.0")),
  TestData(input: "-1.0", output: Ok(-1.0), python_output: Ok("-1.0")),
  TestData(input: "+123.321", output: Ok(123.321), python_output: Ok("123.321")),
  TestData(
    input: "-123.321",
    output: Ok(-123.321),
    python_output: Ok("-123.321"),
  ), TestData(input: "1", output: Ok(1.0), python_output: Ok("1.0")),
  TestData(input: "1.", output: Ok(1.0), python_output: Ok("1.0")),
  TestData(input: ".1", output: Ok(0.1), python_output: Ok("0.1")),
  TestData(input: "0", output: Ok(0.0), python_output: Ok("0.0")),
  TestData(input: "-0", output: Ok(-0.0), python_output: Ok("-0.0")),
  TestData(input: "+0", output: Ok(0.0), python_output: Ok("0.0")),
  TestData(input: "0.0", output: Ok(0.0), python_output: Ok("0.0")),
]

const valid_floats_with_underscores: List(TestData(Float)) = [
  TestData(
    input: "1_000_000.0",
    output: Ok(1_000_000.0),
    python_output: Ok("1000000.0"),
  ),
  TestData(
    input: "1_000_000.000_1",
    output: Ok(1_000_000.0001),
    python_output: Ok("1000000.0001"),
  ),
  TestData(
    input: "1000.000_000",
    output: Ok(1000.0),
    python_output: Ok("1000.0"),
  ),
  TestData(
    input: "1_234_567.890_123",
    output: Ok(1_234_567.890123),
    python_output: Ok("1234567.890123"),
  ),
  TestData(
    input: "0.000_000_1",
    output: Ok(0.0000001),
    python_output: Ok("1e-07"),
  ),
]

const valid_floats_with_whitespace: List(TestData(Float)) = [
  TestData(input: " 1 ", output: Ok(1.0), python_output: Ok("1.0")),
  TestData(input: " 1.0 ", output: Ok(1.0), python_output: Ok("1.0")),
  TestData(input: " 1000 ", output: Ok(1000.0), python_output: Ok("1000.0")),
  TestData(input: "\t3.14\n", output: Ok(3.14), python_output: Ok("3.14")),
  TestData(input: "  -0.5  ", output: Ok(-0.5), python_output: Ok("-0.5")),
]

const valid_floats_with_exponents: List(TestData(Float)) = [
  TestData(input: "4e3", output: Ok(4000.0), python_output: Ok("4000.0")),
  TestData(input: "4e-3", output: Ok(0.004), python_output: Ok("0.004")),
  TestData(input: "4.0e3", output: Ok(4000.0), python_output: Ok("4000.0")),
  TestData(input: "4.0e-3", output: Ok(0.004), python_output: Ok("0.004")),
  TestData(input: "4E3", output: Ok(4000.0), python_output: Ok("4000.0")),
  TestData(input: "4E-3", output: Ok(0.004), python_output: Ok("0.004")),
  TestData(input: "4.0E3", output: Ok(4000.0), python_output: Ok("4000.0")),
  TestData(input: "4.0E-3", output: Ok(0.004), python_output: Ok("0.004")),
  TestData(input: ".3e3", output: Ok(300.0), python_output: Ok("300.0")),
  TestData(input: ".3e-3", output: Ok(0.0003), python_output: Ok("0.0003")),
  TestData(input: "3.e3", output: Ok(3000.0), python_output: Ok("3000.0")),
  TestData(input: "3.e-3", output: Ok(0.003), python_output: Ok("0.003")),
  TestData(input: "1e0", output: Ok(1.0), python_output: Ok("1.0")),
  TestData(input: "1e+3", output: Ok(1000.0), python_output: Ok("1000.0")),
  TestData(input: "1E+3", output: Ok(1000.0), python_output: Ok("1000.0")),
]

const valid_mixed: List(TestData(Float)) = [
  // TestData(
  //   input: "   -30.01e-2   ",
  //   output: Ok(-0.3001),
  //   python_output: Ok("-0.3001"),
  // ),
  TestData(
    input: "+1_234.567_8e-2",
    output: Ok(12.345678),
    python_output: Ok("12.345678"),
  ),
  TestData(input: " -0.000_1E+3 ", output: Ok(-0.1), python_output: Ok("-0.1")),
]

pub fn data() -> List(TestData(Float)) {
  [
    valid_simple_floats,
    valid_floats_with_underscores,
    valid_floats_with_whitespace,
    valid_floats_with_exponents,
    valid_mixed,
  ]
  |> list.flatten
}
