# lenient_parse

[![Package Version](https://img.shields.io/hexpm/v/lenient_parse)](https://hex.pm/packages/lenient_parse)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/lenient_parse/)

A Gleam library providing lenient parsing functions for converting strings to float and integer values. This package offers more flexible parsing than the standard Gleam functions, similar to Python's built-in `float()` and `int()` functions.

## Installation


```sh
gleam add lenient_parse
```
```gleam
import gleam/float
import gleam/int
import gleam/io
import lenient_parse

pub fn main() {
  // Parse a string containing an integer into a float

  "1" |> lenient_parse.to_float |> io.debug // Ok(1.0)
  "1" |> float.parse |> io.debug // Error(Nil)

  // Parse a string containing a negative float

  "-5.001" |> lenient_parse.to_float |> io.debug // Ok(-5.001)
  "-5.001" |> float.parse |> io.debug // Ok(-5.001)

  // Parse a more complex float with scientific notation

  "-1_234.567_8e-2" |> lenient_parse.to_float |> io.debug // Ok(-12.345678)
  "-1_234.567_8e-2" |> float.parse |> io.debug // Error(Nil)

  // Parse a string containing an integer into an integer

  "123" |> lenient_parse.to_int |> io.debug // Ok(123)
  "123" |> int.parse |> io.debug // Ok(123)

  // Parse a string containing a negative integer with surrounding whitespace

  "  -123  " |> lenient_parse.to_int |> io.debug // Ok(-123)
  "  -123  " |> int.parse |> io.debug // Error(Nil)

  // Parse a string containing an integer with underscores

  "1_000_000" |> lenient_parse.to_int |> io.debug // Ok(1000000)
  "1_000_000" |> int.parse |> io.debug // Error(Nil)

  // Parse a binary string

  "1000_0000" |> lenient_parse.to_int_with_base(base: 2) |> io.debug // Ok(128)
  // No direct Gleam stdlib support

  // Parse a hexadecimal string

  "DEAD_BEEF" |> lenient_parse.to_int_with_base(base: 16) |> io.debug// Ok(3735928559)
  // No direct Gleam stdlib support

  // Nice errors

  "12.3e_3" |> lenient_parse.to_float |> io.debug // Error(InvalidUnderscorePosition(5))
  "12.3e_3" |> float.parse |> io.debug // Error(Nil)
}

```

## Developer Setup

To run the tests for this package, you'll need to [install `uv`](https://docs.astral.sh/uv/getting-started/installation/).
