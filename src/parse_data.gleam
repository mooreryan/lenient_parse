import lenient_parse/internal/token.{type Token}

pub type ParseData(t) {
  ParseData(data: t, tokens: List(Token), index: Int)
}
