import gleam/bool
import gleam/float
import gleam/int
import gleam/result
import gleam/string

/// Converts a string to a float using a more lenient parsing method than gleam's `float.parse()`. It behaves similarly to Python's `float()` built-in function.
///
/// ## Examples
///
/// ```gleam
/// lenient_parse.to_float("1.001")    // -> Ok(1.001)
/// lenient_parse.to_float("1")        // -> Ok(1.0)
/// lenient_parse.to_float("1.")       // -> Ok(1.0)
/// lenient_parse.to_float("1.0")      // -> Ok(1.0)
/// lenient_parse.to_float(".1")       // -> Ok(0.1)
/// lenient_parse.to_float("0.1")      // -> Ok(0.1)
/// lenient_parse.to_float("+123.321") // -> Ok(123.321)
/// lenient_parse.to_float("-123.321") // -> Ok(-123.321)
/// lenient_parse.to_float(" 1.0 ")    // -> Ok(1.0)
/// lenient_parse.to_float("1_000.0")  // -> Ok(1000.0)
/// lenient_parse.to_float(" ")        // -> Error(Nil)
/// lenient_parse.to_float("")         // -> Error(Nil)
/// lenient_parse.to_float("abc")      // -> Error(Nil)
/// ```
pub fn to_float(text: String) -> Result(Float, Nil) {
  let text = text |> sanitize

  use <- bool.guard(text |> string.is_empty, Error(Nil))
  use _ <- result.try_recover(text |> float.parse)
  use _ <- result.try_recover(text |> int.parse |> result.map(int.to_float))

  case string.first(text), string.last(text) {
    Ok("."), _ -> float.parse("0" <> text)
    _, Ok(".") -> float.parse(text <> "0")
    _, _ -> Error(Nil)
  }
}

/// Converts a string to an integer using a more lenient parsing method than gleam's `int.parse()`.
/// It behaves similarly to Python's `int()` built-in function.
///
/// ## Examples
///
/// ```gleam
/// lenient_parse.to_int("123")      // -> Ok(123)
/// lenient_parse.to_int("+123")     // -> Ok(123)
/// lenient_parse.to_int("-123")     // -> Ok(-123)
/// lenient_parse.to_int("0123")     // -> Ok(123)
/// lenient_parse.to_int(" 123 ")    // -> Ok(123)
/// lenient_parse.to_int("1_000")    // -> Ok(1000)
/// lenient_parse.to_int("")         // -> Error(Nil)
/// lenient_parse.to_int("1.0")      // -> Error(Nil)
/// lenient_parse.to_int("abc")      // -> Error(Nil)
/// ```
pub fn to_int(text: String) -> Result(Int, Nil) {
  let text = text |> sanitize
  use <- bool.guard(text |> string.is_empty, Error(Nil))
  text |> int.parse
}

fn sanitize(text: String) -> String {
  text |> string.trim |> string.replace("_", "")
}
// TODO: README
// TODO: Publish
// TODO: Support scientific notation
