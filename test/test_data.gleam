import parse_error.{type ParseError}

pub type TestData(t) {
  TestData(
    input: String,
    output: Result(t, ParseError),
    python_output: Result(String, Nil),
  )
}
