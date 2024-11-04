import gleam/int
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

pub fn to_error(token: Token, index) -> ParseError {
  case token {
    Sign(True) -> InvalidSignPosition("+", index)
    Sign(False) -> InvalidSignPosition("-", index)
    Digit(digit) -> InvalidDigitPosition(digit |> int.to_string, index)
    Underscore -> InvalidUnderscorePosition(index)
    DecimalPoint -> InvalidDecimalPosition(index)
    Whitespace(whitespace) -> UnknownCharacter(whitespace, index)
    Unknown(character) -> UnknownCharacter(character, index)
  }
}
