import gleeunit/should
import lenient_parse

pub fn is_valid_number_string_true_test() {
  lenient_parse.is_valid_number_string("0") |> should.equal(True)
  lenient_parse.is_valid_number_string("0.0") |> should.equal(True)
  lenient_parse.is_valid_number_string("0.0.") |> should.equal(False)
  lenient_parse.is_valid_number_string("1_000") |> should.equal(True)
  lenient_parse.is_valid_number_string("1000.000_000")
  |> should.equal(True)
  lenient_parse.is_valid_number_string("+1000") |> should.equal(True)
  lenient_parse.is_valid_number_string("-1000") |> should.equal(True)

  lenient_parse.is_valid_number_string(" 1000 ") |> should.equal(True)
  lenient_parse.is_valid_number_string(" -1000 ") |> should.equal(True)
}

pub fn is_valid_number_string_false_test() {
  lenient_parse.is_valid_number_string("a") |> should.equal(False)
  lenient_parse.is_valid_number_string("1__000") |> should.equal(False)
  lenient_parse.is_valid_number_string("1000_") |> should.equal(False)
  lenient_parse.is_valid_number_string("1000_.") |> should.equal(False)
  lenient_parse.is_valid_number_string("1000_.0") |> should.equal(False)
  lenient_parse.is_valid_number_string("1000._0") |> should.equal(False)
}
