import gleam/dict
import gleam/list
import gleam/string
import lenient_parse/internal/whitespace.{
  carriage_return, form_feed, horizontal_tab, line_feed, space, windows_newline,
}

import lenient_parse/internal/token.{
  DecimalPoint, Digit, ExponentSymbol, Sign, Underscore, Unknown, Whitespace,
}
import lenient_parse/internal/tokenizer
import startest/expect

// With floats, only base 10 is supported. Any letter character (a-z/A-Z),
// outside of an exponent character, should be considered an Unknown.
pub fn tokenize_float_test() {
  " \t\n\r\f\r\n+-0123456789eE._abc"
  |> tokenizer.tokenize_float
  |> expect.to_equal([
    Whitespace(#(0, 1), space),
    Whitespace(#(1, 2), horizontal_tab),
    Whitespace(#(2, 3), line_feed),
    Whitespace(#(3, 4), carriage_return),
    Whitespace(#(4, 5), form_feed),
    Whitespace(#(5, 6), windows_newline),
    Sign(#(6, 7), "+", True),
    Sign(#(7, 8), "-", False),
    Digit(#(8, 9), "0", 0),
    Digit(#(9, 10), "1", 1),
    Digit(#(10, 11), "2", 2),
    Digit(#(11, 12), "3", 3),
    Digit(#(12, 13), "4", 4),
    Digit(#(13, 14), "5", 5),
    Digit(#(14, 15), "6", 6),
    Digit(#(15, 16), "7", 7),
    Digit(#(16, 17), "8", 8),
    Digit(#(17, 18), "9", 9),
    ExponentSymbol(#(18, 19), "e"),
    ExponentSymbol(#(19, 20), "E"),
    DecimalPoint(#(20, 21)),
    Underscore(#(21, 22)),
    Unknown(#(22, 23), "a"),
    Unknown(#(23, 24), "b"),
    Unknown(#(24, 25), "c"),
  ])
}

// With integers, Letter characters (a-z/A-Z) are all supported given the right
// base, so we mark these as Digits.
pub fn tokenize_int_test() {
  " \t\n\r\f\r\n+-abcdefghijklmnopqrstuvwxyz._ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  |> tokenizer.tokenize_int
  |> expect.to_equal([
    Whitespace(#(0, 1), space),
    Whitespace(#(1, 2), horizontal_tab),
    Whitespace(#(2, 3), line_feed),
    Whitespace(#(3, 4), carriage_return),
    Whitespace(#(4, 5), form_feed),
    Whitespace(#(5, 6), windows_newline),
    Sign(#(6, 7), "+", True),
    Sign(#(7, 8), "-", False),
    Digit(#(8, 9), "a", 10),
    Digit(#(9, 10), "b", 11),
    Digit(#(10, 11), "c", 12),
    Digit(#(11, 12), "d", 13),
    Digit(#(12, 13), "e", 14),
    Digit(#(13, 14), "f", 15),
    Digit(#(14, 15), "g", 16),
    Digit(#(15, 16), "h", 17),
    Digit(#(16, 17), "i", 18),
    Digit(#(17, 18), "j", 19),
    Digit(#(18, 19), "k", 20),
    Digit(#(19, 20), "l", 21),
    Digit(#(20, 21), "m", 22),
    Digit(#(21, 22), "n", 23),
    Digit(#(22, 23), "o", 24),
    Digit(#(23, 24), "p", 25),
    Digit(#(24, 25), "q", 26),
    Digit(#(25, 26), "r", 27),
    Digit(#(26, 27), "s", 28),
    Digit(#(27, 28), "t", 29),
    Digit(#(28, 29), "u", 30),
    Digit(#(29, 30), "v", 31),
    Digit(#(30, 31), "w", 32),
    Digit(#(31, 32), "x", 33),
    Digit(#(32, 33), "y", 34),
    Digit(#(33, 34), "z", 35),
    Unknown(#(34, 35), "."),
    Underscore(#(35, 36)),
    Digit(#(36, 37), "A", 10),
    Digit(#(37, 38), "B", 11),
    Digit(#(38, 39), "C", 12),
    Digit(#(39, 40), "D", 13),
    Digit(#(40, 41), "E", 14),
    Digit(#(41, 42), "F", 15),
    Digit(#(42, 43), "G", 16),
    Digit(#(43, 44), "H", 17),
    Digit(#(44, 45), "I", 18),
    Digit(#(45, 46), "J", 19),
    Digit(#(46, 47), "K", 20),
    Digit(#(47, 48), "L", 21),
    Digit(#(48, 49), "M", 22),
    Digit(#(49, 50), "N", 23),
    Digit(#(50, 51), "O", 24),
    Digit(#(51, 52), "P", 25),
    Digit(#(52, 53), "Q", 26),
    Digit(#(53, 54), "R", 27),
    Digit(#(54, 55), "S", 28),
    Digit(#(55, 56), "T", 29),
    Digit(#(56, 57), "U", 30),
    Digit(#(57, 58), "V", 31),
    Digit(#(58, 59), "W", 32),
    Digit(#(59, 60), "X", 33),
    Digit(#(60, 61), "Y", 34),
    Digit(#(61, 62), "Z", 35),
  ])
}

pub fn tokenize_int_with_all_whitespace_characters_test() {
  let whitespace_character_strings = whitespace.character_dict() |> dict.to_list

  let expected_tokens =
    whitespace_character_strings
    |> list.index_map(fn(whitespace_data, index) {
      Whitespace(#(index, index + 1), data: whitespace_data.1)
    })

  let whitespace_character_strings = whitespace.character_dict() |> dict.keys()

  whitespace_character_strings
  |> string.join("")
  |> tokenizer.tokenize_int
  |> expect.to_equal(expected_tokens)
}
