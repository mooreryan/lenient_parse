# lenient_parse

[![Package Version](https://img.shields.io/hexpm/v/lenient_parse)](https://hex.pm/packages/lenient_parse)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/lenient_parse/)

```sh
gleam add lenient_parse
```
```gleam
import lenient_parse
import gleam/float
import gleam/io

pub fn main() {
  "1" |> float.parse |> io.debug
  // Error(Nil)

  "1" |> lenient_parse.to_float |> io.debug
  // Ok(1.0)
}
```
