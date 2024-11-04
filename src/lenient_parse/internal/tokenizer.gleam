import gleam/list
import gleam/string

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
