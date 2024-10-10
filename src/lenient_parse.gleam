import gleam/bool
import gleam/float
import gleam/int
import gleam/result
import gleam/string

/// Converts a string to a float using a more lenient parsing method than gleam's `float.parse()`. It behaves similarly to Python's `float()` built-in function.
///
/// It attempts to parse the input string in the following order:
/// 1. As a standard float
/// 2. As an integer (which is then converted to a float)
/// 3. As a float with leading or trailing decimal point
///
/// ## Examples
///
/// ```gleam
/// lenient_parse.to_float("3.14") // -> Ok(3.14)
/// lenient_parse.to_float("42")   // -> Ok(42.0)
/// lenient_parse.to_float(".5")   // -> Ok(0.5)
/// lenient_parse.to_float("2.")   // -> Ok(2.0)
/// lenient_parse.to_float("dog")  // -> Error(Nil)
/// ```
pub fn to_float(text: String) -> Result(Float, Nil) {
  let text = text |> string.trim

  use <- bool.guard(text |> string.is_empty, Error(Nil))
  use _ <- result.try_recover(text |> float.parse)
  use _ <- result.try_recover(text |> int.parse |> result.map(int.to_float))

  case string.first(text), string.last(text) {
    Ok("."), _ -> float.parse("0" <> text)
    _, Ok(".") -> float.parse(text <> "0")
    _, _ -> Error(Nil)
  }
}
// TODO: Update doc comment with rules and examples
