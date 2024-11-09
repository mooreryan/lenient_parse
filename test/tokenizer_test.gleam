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
    Digit("0", 0, 10),
    Digit("1", 1, 10),
    Digit("2", 2, 10),
    Digit("3", 3, 10),
    Digit("4", 4, 10),
    Digit("5", 5, 10),
    Digit("6", 6, 10),
    Digit("7", 7, 10),
    Digit("8", 8, 10),
    Digit("9", 9, 10),
    ExponentSymbol("e"),
    ExponentSymbol("E"),
    DecimalPoint,
    Underscore,
    Unknown("a"),
    Unknown("b"),
    Unknown("c"),
  ])
}

pub fn tokenize_int_base_10_test() {
  " \t\n\r\f\r\n+-0123456789eE._abcZ"
  |> tokenizer.tokenize_int(base: 10)
  |> expect.to_equal([
    Whitespace(" "),
    Whitespace("\t"),
    Whitespace("\n"),
    Whitespace("\r"),
    Whitespace("\f"),
    Whitespace("\r\n"),
    Sign("+", True),
    Sign("-", False),
    Digit("0", 0, 10),
    Digit("1", 1, 10),
    Digit("2", 2, 10),
    Digit("3", 3, 10),
    Digit("4", 4, 10),
    Digit("5", 5, 10),
    Digit("6", 6, 10),
    Digit("7", 7, 10),
    Digit("8", 8, 10),
    Digit("9", 9, 10),
    Digit("e", 14, 10),
    Digit("E", 14, 10),
    Unknown("."),
    Underscore,
    Digit("a", 10, 10),
    Digit("b", 11, 10),
    Digit("c", 12, 10),
    Digit("Z", 35, 10),
  ])
}

pub fn tokenize_int_base_2_test() {
  "0102101"
  |> tokenizer.tokenize_int(base: 2)
  |> expect.to_equal([
    Digit("0", 0, 2),
    Digit("1", 1, 2),
    Digit("0", 0, 2),
    Digit("2", 2, 2),
    Digit("1", 1, 2),
    Digit("0", 0, 2),
    Digit("1", 1, 2),
  ])
}

pub fn tokenize_int_base_16_test() {
  "dead_beefZ"
  |> tokenizer.tokenize_int(base: 16)
  |> expect.to_equal([
    Digit("d", 0xD, 16),
    Digit("e", 0xE, 16),
    Digit("a", 0xA, 16),
    Digit("d", 0xD, 16),
    Underscore,
    Digit("b", 0xB, 16),
    Digit("e", 0xE, 16),
    Digit("e", 0xE, 16),
    Digit("f", 0xF, 16),
    Digit("Z", 35, 16),
  ])
}

pub fn tokenize_int_base_35_test() {
  "1234567890abcdefghijklmnopqrstuvwxyz"
  |> tokenizer.tokenize_int(base: 35)
  |> expect.to_equal([
    Digit("1", 1, 35),
    Digit("2", 2, 35),
    Digit("3", 3, 35),
    Digit("4", 4, 35),
    Digit("5", 5, 35),
    Digit("6", 6, 35),
    Digit("7", 7, 35),
    Digit("8", 8, 35),
    Digit("9", 9, 35),
    Digit("0", 0, 35),
    Digit("a", 10, 35),
    Digit("b", 11, 35),
    Digit("c", 12, 35),
    Digit("d", 13, 35),
    Digit("e", 14, 35),
    Digit("f", 15, 35),
    Digit("g", 16, 35),
    Digit("h", 17, 35),
    Digit("i", 18, 35),
    Digit("j", 19, 35),
    Digit("k", 20, 35),
    Digit("l", 21, 35),
    Digit("m", 22, 35),
    Digit("n", 23, 35),
    Digit("o", 24, 35),
    Digit("p", 25, 35),
    Digit("q", 26, 35),
    Digit("r", 27, 35),
    Digit("s", 28, 35),
    Digit("t", 29, 35),
    Digit("u", 30, 35),
    Digit("v", 31, 35),
    Digit("w", 32, 35),
    Digit("x", 33, 35),
    Digit("y", 34, 35),
    Digit("z", 35, 35),
  ])
}

pub fn tokenize_int_base_36_test() {
  "159az"
  |> tokenizer.tokenize_int(base: 36)
  |> expect.to_equal([
    Digit("1", 1, 36),
    Digit("5", 5, 36),
    Digit("9", 9, 36),
    Digit("a", 10, 36),
    Digit("z", 35, 36),
  ])
}

pub fn tokenize_int_invalid_1_test() {
  "1"
  |> tokenizer.tokenize_int(base: 1)
  |> expect.to_equal([Digit("1", 1, 1)])
}

pub fn tokenize_int_invalid_2_test() {
  "1"
  |> tokenizer.tokenize_int(base: 37)
  |> expect.to_equal([Digit("1", 1, 37)])
}
