import lenient_parse/internal/token.{
  DecimalPoint, Digit, ExponentSymbol, Sign, Underscore, Unknown, Whitespace,
}
import lenient_parse/internal/tokenizer
import startest/expect

pub fn tokenize_float_test() {
  " \t\n\r\f\r\n+-0123456789eE._abc"
  |> tokenizer.tokenize_float
  |> expect.to_equal([
    Whitespace(" "),
    Whitespace("\t"),
    Whitespace("\n"),
    Whitespace("\r"),
    Whitespace("\f"),
    Whitespace("\r\n"),
    Sign("+", True),
    Sign("-", False),
    Digit(0),
    Digit(1),
    Digit(2),
    Digit(3),
    Digit(4),
    Digit(5),
    Digit(6),
    Digit(7),
    Digit(8),
    Digit(9),
    ExponentSymbol("e"),
    ExponentSymbol("E"),
    DecimalPoint,
    Underscore,
    Unknown("a"),
    Unknown("b"),
    Unknown("c"),
  ])
}

pub fn tokenize_int_test() {
  " \t\n\r\f\r\n+-0123456789eE._abc"
  |> tokenizer.tokenize_int
  |> expect.to_equal([
    Whitespace(" "),
    Whitespace("\t"),
    Whitespace("\n"),
    Whitespace("\r"),
    Whitespace("\f"),
    Whitespace("\r\n"),
    Sign("+", True),
    Sign("-", False),
    Digit(0),
    Digit(1),
    Digit(2),
    Digit(3),
    Digit(4),
    Digit(5),
    Digit(6),
    Digit(7),
    Digit(8),
    Digit(9),
    Unknown("e"),
    Unknown("E"),
    Unknown("."),
    Underscore,
    Unknown("a"),
    Unknown("b"),
    Unknown("c"),
  ])
}
