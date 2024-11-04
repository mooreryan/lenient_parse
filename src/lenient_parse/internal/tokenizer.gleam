import gleam/int
import gleam/list
import gleam/string
import parse_error.{
  type ParseError, InvalidDecimalPosition, InvalidDigitPosition,
  InvalidSignPosition, InvalidUnderscorePosition, UnknownCharacter,
}

pub type Token {
  Sign(Bool)
  Digit(Int)
  Underscore
  DecimalPoint
  Whitespace(String)
  Unknown(String)
}

pub fn tokenize(text: String) -> List(Token) {
  text |> string.to_graphemes |> do_tokenize([])
}

fn do_tokenize(characters: List(String), acc: List(Token)) -> List(Token) {
  case characters {
    [] -> acc |> list.reverse
    [first, ..rest] -> {
      let token = case first {
        "-" -> Sign(False)
        "+" -> Sign(True)
        "0" -> Digit(0)
        "1" -> Digit(1)
        "2" -> Digit(2)
        "3" -> Digit(3)
        "4" -> Digit(4)
        "5" -> Digit(5)
        "6" -> Digit(6)
        "7" -> Digit(7)
        "8" -> Digit(8)
        "9" -> Digit(9)
        "." -> DecimalPoint
        "_" -> Underscore
        " " | "\n" | "\t" | "\r" | "\f" | "\r\n" -> Whitespace(first)
        _ -> Unknown(first)
      }

      do_tokenize(rest, [token, ..acc])
    }
  }
}

pub fn to_error(token: Token, index) -> ParseError {
  case token {
    Digit(digit) -> {
      let digit = digit |> int.to_string
      InvalidDigitPosition(digit, index)
    }
    Sign(True) -> InvalidSignPosition("+", index)
    Sign(False) -> InvalidSignPosition("-", index)
    Underscore -> InvalidUnderscorePosition(index)
    Unknown(character) -> UnknownCharacter(character, index)
    Whitespace(whitespace) -> UnknownCharacter(whitespace, index)
    DecimalPoint -> InvalidDecimalPosition(index)
  }
}
