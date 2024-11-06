import gleam/list
import gleam/string
import lenient_parse/internal/token.{
  type Token, DecimalPoint, Digit, Exponent, Sign, Underscore, Unknown,
  Whitespace,
}

pub fn tokenize_float(text: String) -> List(Token) {
  text |> string.to_graphemes |> do_tokenize_float([])
}

pub fn tokenize_int(text: String) -> List(Token) {
  text |> string.to_graphemes |> do_tokenize_int([])
}

fn do_tokenize_float(characters: List(String), acc: List(Token)) -> List(Token) {
  case characters {
    [] -> acc |> list.reverse
    [first, ..rest] -> {
      let token = int_token(first)
      let token = case token {
        Unknown(a) | Unknown(a) if a == "e" || a == "E" -> Exponent(a)
        _ -> token
      }

      do_tokenize_float(rest, [token, ..acc])
    }
  }
}

fn do_tokenize_int(characters: List(String), acc: List(Token)) -> List(Token) {
  case characters {
    [] -> acc |> list.reverse
    [first, ..rest] -> {
      let token = int_token(first)
      do_tokenize_int(rest, [token, ..acc])
    }
  }
}

fn int_token(character: String) -> Token {
  case character {
    "-" -> Sign("-", False)
    "+" -> Sign("+", True)
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
    " " | "\n" | "\t" | "\r" | "\f" | "\r\n" -> Whitespace(character)
    _ -> Unknown(character)
  }
}
