import gleeunit/should
import lenient_parse

pub fn to_int_standard_format_test() {
  "1"
  |> lenient_parse.to_int
  |> should.equal(Ok(1))

  "+123"
  |> lenient_parse.to_int
  |> should.equal(Ok(123))

  "0123"
  |> lenient_parse.to_int
  |> should.equal(Ok(123))

  "-123"
  |> lenient_parse.to_int
  |> should.equal(Ok(-123))
}

pub fn to_int_underscore_test() {
  "1_000_000"
  |> lenient_parse.to_int
  |> should.equal(Ok(1_000_000))
}

pub fn to_int_whitespace_test() {
  " 1 "
  |> lenient_parse.to_int
  |> should.equal(Ok(1))
}

pub fn to_int_shouldnt_parse_test() {
  "1."
  |> lenient_parse.to_int
  |> should.equal(Error(Nil))

  "1.0"
  |> lenient_parse.to_int
  |> should.equal(Error(Nil))

  " "
  |> lenient_parse.to_int
  |> should.equal(Error(Nil))

  ""
  |> lenient_parse.to_int
  |> should.equal(Error(Nil))

  "abc"
  |> lenient_parse.to_int
  |> should.equal(Error(Nil))
}
