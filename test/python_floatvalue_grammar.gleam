import gleam/io
import gleam/list
import gleam/option
import gleam/string
import qcheck

// TODO: you could potentially speed things up by replacing the options with
// potentially empty strings.

// This is based on the grammar found in the Python docs:
// https://docs.python.org/3/library/functions.html#float

// sign ::= "+" | "-"
fn sign() {
  qcheck.char_from_list(["+", "-"])
}

// infinity ::= "Infinity" | "inf"
fn infinity() {
  qcheck.from_generators([
    qcheck.return("inf") |> qcheck.bind(scramble_case),
    qcheck.return("infinity") |> qcheck.bind(scramble_case),
  ])
}

// nan ::= "nan"
fn nan() {
  qcheck.return("nan") |> qcheck.bind(scramble_case)
}

// digit ::= <a Unicode decimal digit, i.e. characters in Unicode general
//            category Nd>
fn digit() {
  // TODO: the grammar says it should be "a Unicode decimal digit, i.e.
  // characters in Unicode general category Nd", which is more than 0-9.  But
  // use 0-9 to start.
  qcheck.char_digit()
}

// ["_"] digit
fn trailing_digitpart() -> qcheck.Generator(String) {
  use underscore, digit <- qcheck.map2(
    g1: qcheck.option(qcheck.return("_")),
    g2: digit(),
  )
  unwrap_string(underscore) <> digit
}

// (["_"] digit)*
fn trailing_digitparts() -> qcheck.Generator(String) {
  qcheck.string_from(trailing_digitpart())
}

// digitpart ::= digit (["_"] digit)*
fn digitpart() -> qcheck.Generator(String) {
  use first_digit, remaining_digits <- qcheck.map2(
    g1: digit(),
    g2: trailing_digitparts(),
  )

  first_digit <> remaining_digits
}

fn dot_digitpart() {
  use digitpart <- qcheck.map(digitpart())
  "." <> digitpart
}

// [digitpart] "." digitpart
fn number_left_case() -> qcheck.Generator(String) {
  use first_digitpart, dot_digitpart <- qcheck.map2(
    g1: qcheck.option(digitpart()),
    g2: dot_digitpart(),
  )

  unwrap_string(first_digitpart) <> dot_digitpart
}

// digitpart ["."]
fn number_right_case() -> qcheck.Generator(String) {
  use digitpart, maybe_dot <- qcheck.map2(
    g1: digitpart(),
    g2: qcheck.option(qcheck.return(".")),
  )
  digitpart <> unwrap_string(maybe_dot)
}

// number ::= [digitpart] "." digitpart | digitpart ["."]
fn number() -> qcheck.Generator(String) {
  qcheck.from_generators([number_left_case(), number_right_case()])
}

fn e() {
  qcheck.char_from_list(["e", "E"])
}

// exponent ::= ("e" | "E") [sign] digitpart
fn exponent() -> qcheck.Generator(String) {
  use e, sign, digitpart <- qcheck.map3(
    g1: e(),
    g2: qcheck.option(sign()),
    g3: digitpart(),
  )
  e <> unwrap_string(sign) <> digitpart
}

// floatnumber ::= number [exponent]
fn floatnumber() -> qcheck.Generator(String) {
  use number, exponent <- qcheck.map2(
    g1: number(),
    g2: qcheck.option(exponent()),
  )
  number <> unwrap_string(exponent)
}

// absfloatvalue ::= floatnumber | infinity | nan
fn absfloatvalue() -> qcheck.Generator(String) {
  let floatnumber = #(8, floatnumber())
  let infinity = #(1, infinity())
  let nan = #(1, nan())
  qcheck.from_weighted_generators([floatnumber, infinity, nan])
}

// floatvalue ::= [sign] absfloatvalue
pub fn floatvalue() -> qcheck.Generator(String) {
  use sign, absfloatvalue <- qcheck.map2(
    g1: qcheck.option(sign()),
    g2: absfloatvalue(),
  )
  unwrap_string(sign) <> absfloatvalue
}

pub fn finite_floatvalue() -> qcheck.Generator(String) {
  use sign, floatnumber <- qcheck.map2(
    g1: qcheck.option(sign()),
    g2: floatnumber(),
  )
  unwrap_string(sign) <> floatnumber
}

fn whitespace_string() {
  qcheck.string_from(qcheck.char_whitespace())
}

fn unwrap_string(maybe_string: option.Option(String)) -> String {
  case maybe_string {
    option.None -> ""
    option.Some(string) -> string
  }
}

/// Potentially "embed" the given `string` in whitespace characters.
fn embed_in_whitespace(string: String) -> qcheck.Generator(String) {
  use leading_whitespace, trailing_whitespace <- qcheck.map2(
    g1: whitespace_string(),
    g2: whitespace_string(),
  )

  leading_whitespace <> string <> trailing_whitespace
}

pub fn floatvalue_in_whitespace() {
  qcheck.bind(floatvalue(), embed_in_whitespace)
}

pub fn finite_floatvalue_in_whitespace() {
  qcheck.bind(finite_floatvalue(), embed_in_whitespace)
}

type UpperOrLower {
  Upper
  Lower
}

fn upper_or_lower() {
  qcheck.from_generators([qcheck.return(Upper), qcheck.return(Lower)])
}

fn list_cons(x, xs) {
  [x, ..xs]
}

fn sequence_list(l: List(qcheck.Generator(a))) -> qcheck.Generator(List(a)) {
  case l {
    [] -> qcheck.return([])
    [hd, ..tl] -> {
      qcheck.map2(list_cons, hd, sequence_list(tl))
    }
  }
}

fn scramble_case(str: String) -> qcheck.Generator(String) {
  str
  |> string.to_graphemes()
  |> list.map(fn(grapheme) {
    qcheck.map(upper_or_lower(), fn(upper_or_lower) {
      case upper_or_lower {
        Upper -> string.uppercase(grapheme)
        Lower -> string.lowercase(grapheme)
      }
    })
  })
  |> sequence_list
  |> qcheck.map(fn(graphemes) { string.join(graphemes, "") })
}
