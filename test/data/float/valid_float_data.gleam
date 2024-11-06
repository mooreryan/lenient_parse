import gleam/list
import types.{type FloatTestData, FloatTestData}

const valid_simple_floats: List(FloatTestData) = [
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
  FloatTestData(input: "0", output: Ok(0.0), python_output: Ok("0.0")),
  FloatTestData(input: "-0", output: Ok(-0.0), python_output: Ok("-0.0")),
  FloatTestData(input: "+0", output: Ok(0.0), python_output: Ok("0.0")),
  FloatTestData(input: "0.0", output: Ok(0.0), python_output: Ok("0.0")),
]

const valid_floats_with_underscores: List(FloatTestData) = [
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
    input: "1_234_567.890_123",
    output: Ok(1_234_567.890123),
    python_output: Ok("1234567.890123"),
  ),
  FloatTestData(
    input: "0.000_000_1",
    output: Ok(0.0000001),
    python_output: Ok("1e-07"),
  ),
]

const valid_floats_with_whitespace: List(FloatTestData) = [
  FloatTestData(input: " 1 ", output: Ok(1.0), python_output: Ok("1.0")),
  FloatTestData(input: " 1.0 ", output: Ok(1.0), python_output: Ok("1.0")),
  FloatTestData(
    input: " 1000 ",
    output: Ok(1000.0),
    python_output: Ok("1000.0"),
  ),
  FloatTestData(input: "\t3.14\n", output: Ok(3.14), python_output: Ok("3.14")),
  FloatTestData(input: "  -0.5  ", output: Ok(-0.5), python_output: Ok("-0.5")),
]

const valid_floats_with_exponents: List(FloatTestData) = [
  FloatTestData(input: "4e3", output: Ok(4000.0), python_output: Ok("4000.0")),
  FloatTestData(input: "4e-3", output: Ok(0.004), python_output: Ok("0.004")),
  FloatTestData(input: "4.0e3", output: Ok(4000.0), python_output: Ok("4000.0")),
  FloatTestData(input: "4.0e-3", output: Ok(0.004), python_output: Ok("0.004")),
  FloatTestData(input: "4E3", output: Ok(4000.0), python_output: Ok("4000.0")),
  FloatTestData(input: "4E-3", output: Ok(0.004), python_output: Ok("0.004")),
  FloatTestData(input: "4.0E3", output: Ok(4000.0), python_output: Ok("4000.0")),
  FloatTestData(input: "4.0E-3", output: Ok(0.004), python_output: Ok("0.004")),
  FloatTestData(input: ".3e3", output: Ok(300.0), python_output: Ok("300.0")),
  FloatTestData(input: ".3e-3", output: Ok(0.0003), python_output: Ok("0.0003")),
  FloatTestData(input: "3.e3", output: Ok(3000.0), python_output: Ok("3000.0")),
  FloatTestData(input: "3.e-3", output: Ok(0.003), python_output: Ok("0.003")),
  FloatTestData(input: "1e0", output: Ok(1.0), python_output: Ok("1.0")),
  FloatTestData(input: "1e+3", output: Ok(1000.0), python_output: Ok("1000.0")),
  FloatTestData(input: "1E+3", output: Ok(1000.0), python_output: Ok("1000.0")),
]

const valid_mixed: List(FloatTestData) = [
  // FloatTestData(
  //   input: "   -30.01e-2   ",
  //   output: Ok(-0.3001),
  //   python_output: Ok("-0.3001"),
  // ),
  FloatTestData(
    input: "+1_234.567_8e-2",
    output: Ok(12.345678),
    python_output: Ok("12.345678"),
  ),
  FloatTestData(
    input: " -0.000_1E+3 ",
    output: Ok(-0.1),
    python_output: Ok("-0.1"),
  ),
]

pub fn data() -> List(FloatTestData) {
  [
    valid_simple_floats,
    valid_floats_with_underscores,
    valid_floats_with_whitespace,
    valid_floats_with_exponents,
    valid_mixed,
  ]
  |> list.flatten
}