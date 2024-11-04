import gleam/list
import gleam/string
import parse_error.{
  type ParseError, InvalidDecimalPosition, InvalidDigitPosition,
  InvalidSignPosition, InvalidUnderscorePosition, UnknownCharacter,
}

pub type Token {
  Sign(String)
  Digit(String)
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
        "-" | "+" -> Sign(first)
        "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ->
          Digit(first)
        "." -> DecimalPoint
        "_" -> Underscore
        " " | "\n" | "\t" | "\r" | "\f" | "\r\n" -> Whitespace(first)
        _ -> Unknown(first)
      }

      do_tokenize(rest, [token, ..acc])
    }
  }
}

pub fn error_for_token(token: Token, index) -> ParseError {
  case token {
    Digit(digit) -> InvalidDigitPosition(digit, index)
    Sign(sign) -> InvalidSignPosition(sign, index)
    Underscore -> InvalidUnderscorePosition(index)
    Unknown(character) -> UnknownCharacter(character, index)
    Whitespace(whitespace) -> UnknownCharacter(whitespace, index)
    DecimalPoint -> InvalidDecimalPosition(index)
  }
}
