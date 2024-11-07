import gleam/bool
import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/order
import gleam/result
import lenient_parse/internal/token.{
  type Token, DecimalPoint, Digit, Exponent, Sign, Underscore, Unknown,
  Whitespace,
}

import lenient_parse/internal/tokenizer
import parse_data.{type ParseData, ParseData}
import parse_error.{
  type ParseError, EmptyString, InvalidDecimalPosition,
  InvalidExponentSymbolPosition, InvalidUnderscorePosition, UnknownCharacter,
  WhitespaceOnlyString,
}

pub fn parse_float(input: String) -> Result(Float, ParseError) {
  let tokens = input |> tokenizer.tokenize_float
  let index = 0

  let parse_data = parse_whitespace(tokens, index)
  use ParseData(leading_whitespace, tokens, index) <- result.try(parse_data)

  let parse_data = parse_sign(tokens, index)
  use ParseData(is_positive, tokens, index) <- result.try(parse_data)

  let parse_data = parse_digit(tokens, index)
  use ParseData(#(whole_digit, _), tokens, index) <- result.try(parse_data)

  let parse_data = parse_decimal_point(tokens, index)
  use ParseData(decimal_specified, tokens, index) <- result.try(parse_data)

  let parse_data = case decimal_specified {
    True -> parse_digit(tokens, index)
    False -> Ok(ParseData(#(None, 0), tokens, index))
  }
  use ParseData(#(fractional_digit, fractional_length), tokens, index) <- result.try(
    parse_data,
  )

  let missing_digit_parts =
    option.is_none(whole_digit) && option.is_none(fractional_digit)
  use <- bool.guard(
    missing_digit_parts && decimal_specified,
    Error(InvalidDecimalPosition(index - 1)),
  )

  let parse_data = parse_exponent_symbol(tokens, index)
  use ParseData(exponent_symbol, tokens, index) <- result.try(parse_data)

  let parse_data = case missing_digit_parts, exponent_symbol {
    True, Some(exponent_symbol) ->
      Error(InvalidExponentSymbolPosition(exponent_symbol, index - 1))
    _, None -> Ok(ParseData(#(0, True), tokens, index))
    _, Some(exponent_symbol) -> {
      let parse_data = parse_sign(tokens, index)
      use ParseData(exponent_digit_is_positive, tokens, index) <- result.try(
        parse_data,
      )

      let parse_data = parse_digit(tokens, index)
      use ParseData(#(exponent_digit, exponent_digit_length), tokens, index) <- result.try(
        parse_data,
      )

      let parse_data = case exponent_digit {
        Some(exponent_digit) ->
          Ok(ParseData(#(exponent_digit, exponent_digit_length), tokens, index))
        None -> Error(InvalidExponentSymbolPosition(exponent_symbol, index - 1))
      }
      use ParseData(#(exponent_digit, _), tokens, index) <- result.try(
        parse_data,
      )

      Ok(ParseData(#(exponent_digit, exponent_digit_is_positive), tokens, index))
    }
  }
  use ParseData(#(exponent_digit, exponent_digit_is_positive), tokens, index) <- result.try(
    parse_data,
  )

  let parse_data = parse_whitespace(tokens, index)
  use ParseData(_, tokens, index) <- result.try(parse_data)

  let remaining_token_result = case tokens {
    [] -> Ok(Nil)
    [token, ..] -> Error(token.to_error(token, index))
  }
  use _ <- result.try(remaining_token_result)

  case leading_whitespace, whole_digit, fractional_digit {
    None, None, None -> Error(EmptyString)
    Some(_), None, None -> Error(WhitespaceOnlyString)
    _, _, _ ->
      Ok(form_float(
        is_positive: is_positive,
        whole_digit: whole_digit |> option.unwrap(0),
        fractional_digit: fractional_digit |> option.unwrap(0),
        fractional_length: fractional_length,
        exponent_digit_is_positive: exponent_digit_is_positive,
        exponent_digit: exponent_digit,
      ))
  }
}

pub fn parse_int(input: String) -> Result(Int, ParseError) {
  let tokens = input |> tokenizer.tokenize_int
  let index = 0

  let parse_data = parse_whitespace(tokens, index)
  use ParseData(leading_whitespace, tokens, index) <- result.try(parse_data)

  let parse_data = parse_sign(tokens, index)
  use ParseData(is_positive, tokens, index) <- result.try(parse_data)

  let parse_data = parse_digit(tokens, index)
  use ParseData(#(digit, _), tokens, index) <- result.try(parse_data)

  let parse_data = parse_whitespace(tokens, index)
  use ParseData(_, tokens, index) <- result.try(parse_data)

  let remaining_token_result = case tokens {
    [] -> Ok(Nil)
    [token, ..] -> Error(token.to_error(token, index))
  }
  use _ <- result.try(remaining_token_result)

  case is_positive, leading_whitespace, digit {
    _, None, None -> Error(EmptyString)
    _, Some(_), None -> Error(WhitespaceOnlyString)
    True, _, Some(digit) -> Ok(digit)
    False, _, Some(digit) -> Ok(-digit)
  }
}

fn parse_whitespace(
  tokens: List(Token),
  index: Int,
) -> Result(ParseData(Option(String)), ParseError) {
  do_parse_whitespace(tokens: tokens, index: index, acc: "")
}

fn do_parse_whitespace(
  tokens tokens: List(Token),
  index index: Int,
  acc acc: String,
) -> Result(ParseData(Option(String)), ParseError) {
  case tokens {
    [Unknown(character), ..] -> Error(UnknownCharacter(character, index))
    [Whitespace(whitespace), ..rest] ->
      do_parse_whitespace(
        tokens: rest,
        index: index + 1,
        acc: acc <> whitespace,
      )
    _ -> {
      let data = case acc {
        "" -> None
        _ -> Some(acc)
      }

      Ok(ParseData(data: data, tokens: tokens, index: index))
    }
  }
}

fn parse_sign(
  tokens: List(Token),
  index: Int,
) -> Result(ParseData(Bool), ParseError) {
  case tokens {
    [Unknown(character), ..] -> Error(UnknownCharacter(character, index))
    [Sign(_, is_positive), ..rest] ->
      Ok(ParseData(data: is_positive, tokens: rest, index: index + 1))
    _ -> Ok(ParseData(data: True, tokens: tokens, index: index))
  }
}

fn parse_decimal_point(
  tokens: List(Token),
  index: Int,
) -> Result(ParseData(Bool), ParseError) {
  case tokens {
    [Unknown(character), ..] -> Error(UnknownCharacter(character, index))
    [DecimalPoint, ..rest] ->
      Ok(ParseData(data: True, tokens: rest, index: index + 1))
    _ -> Ok(ParseData(data: False, tokens: tokens, index: index))
  }
}

fn parse_exponent_symbol(
  tokens: List(Token),
  index: Int,
) -> Result(ParseData(Option(String)), ParseError) {
  case tokens {
    [Unknown(character), ..] -> Error(UnknownCharacter(character, index))
    [Exponent(exponent), ..rest] ->
      Ok(ParseData(data: Some(exponent), tokens: rest, index: index + 1))
    _ -> Ok(ParseData(data: None, tokens: tokens, index: index))
  }
}

fn parse_digit(
  tokens: List(Token),
  index: Int,
) -> Result(ParseData(#(Option(Int), Int)), ParseError) {
  do_parse_digit(
    tokens: tokens,
    index: index,
    acc: 0,
    at_beginning: True,
    digit_length: 0,
  )
}

fn do_parse_digit(
  tokens tokens: List(Token),
  index index: Int,
  acc acc: Int,
  at_beginning at_beginning: Bool,
  digit_length digit_length: Int,
) -> Result(ParseData(#(Option(Int), Int)), ParseError) {
  case tokens {
    [Unknown(character), ..] -> Error(UnknownCharacter(character, index))
    [Whitespace(whitespace), ..] if at_beginning ->
      Error(UnknownCharacter(whitespace, index))
    [Underscore, ..rest] -> {
      let lookahead = rest |> list.first
      let at_end = case lookahead {
        Ok(Digit(_)) -> False
        _ -> True
      }
      let next_is_underscore = case lookahead {
        Ok(Underscore) -> True
        _ -> False
      }

      use <- bool.guard(
        next_is_underscore,
        Error(InvalidUnderscorePosition(index + 1)),
      )

      use <- bool.guard(
        at_beginning || at_end,
        Error(InvalidUnderscorePosition(index)),
      )

      do_parse_digit(
        tokens: rest,
        index: index + 1,
        acc: acc,
        at_beginning: False,
        digit_length: digit_length,
      )
    }
    [Digit(digit), ..rest] ->
      do_parse_digit(
        tokens: rest,
        index: index + 1,
        acc: acc * 10 + digit,
        at_beginning: False,
        digit_length: digit_length + 1,
      )
    _ -> {
      let acc = case digit_length > 0 {
        True -> Some(acc)
        False -> None
      }

      Ok(ParseData(data: #(acc, digit_length), tokens: tokens, index: index))
    }
  }
}

fn form_float(
  is_positive is_positive: Bool,
  whole_digit whole_digit: Int,
  fractional_digit fractional_digit: Int,
  fractional_length fractional_length: Int,
  exponent_digit_is_positive exponent_digit_is_positive: Bool,
  exponent_digit exponent_digit: Int,
) -> Float {
  let whole_float = whole_digit |> int.to_float
  let fractional_float =
    fractional_digit
    |> int.to_float
    |> power(-fractional_length)
  let float_value = whole_float +. fractional_float
  let float_value = case is_positive {
    True -> float_value
    False -> float_value *. -1.0
  }

  let exponent_digit = case exponent_digit_is_positive {
    True -> exponent_digit
    False -> exponent_digit * -1
  }

  power(float_value, exponent_digit)
}

fn power(base: Float, exponent: Int) {
  do_power(
    base: base,
    exponent: exponent,
    scale_factor: 1,
    exponent_is_positive: exponent >= 0,
  )
}

fn do_power(
  base base: Float,
  exponent exponent: Int,
  scale_factor scale_factor: Int,
  exponent_is_positive exponent_is_positive,
) -> Float {
  case int.compare(exponent, 0) {
    order.Eq -> {
      let scale_factor_float = scale_factor |> int.to_float
      case exponent_is_positive {
        True -> base *. scale_factor_float
        False -> base /. scale_factor_float
      }
    }
    order.Gt ->
      do_power(base, exponent - 1, scale_factor * 10, exponent_is_positive)
    order.Lt ->
      do_power(base, exponent + 1, scale_factor * 10, exponent_is_positive)
  }
}
