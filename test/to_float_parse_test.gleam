import gleeunit/should
import lenient_parse

pub fn to_float_standard_format_test() {
  "1.001"
  |> lenient_parse.to_float
  |> should.equal(Ok(1.001))

  "1.00"
  |> lenient_parse.to_float
  |> should.equal(Ok(1.0))

  "1.0"
  |> lenient_parse.to_float
  |> should.equal(Ok(1.0))

  "0.1"
  |> lenient_parse.to_float
  |> should.equal(Ok(0.1))

  "+123.321"
  |> lenient_parse.to_float
  |> should.equal(Ok(123.321))

  "-123.321"
  |> lenient_parse.to_float
  |> should.equal(Ok(-123.321))
}

pub fn to_float_int_test() {
  "1"
  |> lenient_parse.to_float
  |> should.equal(Ok(1.0))
}

pub fn to_float_leading_trailing_dot_test() {
  "1."
  |> lenient_parse.to_float
  |> should.equal(Ok(1.0))

  ".1"
  |> lenient_parse.to_float
  |> should.equal(Ok(0.1))
}

pub fn to_float_underscore_test() {
  "1_000_000.0"
  |> lenient_parse.to_float
  |> should.equal(Ok(1_000_000.0))
}

pub fn to_float_whitespace_test() {
  " 1 "
  |> lenient_parse.to_float
  |> should.equal(Ok(1.0))

  " 1.0 "
  |> lenient_parse.to_float
  |> should.equal(Ok(1.0))
}

// pub fn to_float_scientific_notation_test() {
//   // "420e3"
//   // |> lenient_parse.to_float
//   // |> should.equal(Ok(1e10))

//   // "420e-3"
//   // |> lenient_parse.to_float
//   // |> should.equal(Ok(-2.5e-3))
// }

pub fn to_float_shouldnt_parse_test() {
  "..1"
  |> lenient_parse.to_float
  |> should.equal(Error(Nil))

  "1.."
  |> lenient_parse.to_float
  |> should.equal(Error(Nil))

  ".1."
  |> lenient_parse.to_float
  |> should.equal(Error(Nil))

  "."
  |> lenient_parse.to_float
  |> should.equal(Error(Nil))

  " "
  |> lenient_parse.to_float
  |> should.equal(Error(Nil))

  ""
  |> lenient_parse.to_float
  |> should.equal(Error(Nil))

  "abc"
  |> lenient_parse.to_float
  |> should.equal(Error(Nil))
}
