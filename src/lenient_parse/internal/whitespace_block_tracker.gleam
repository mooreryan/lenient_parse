import gleam/int
import lenient_parse/internal/tokenizer.{type Token, Whitespace}

pub opaque type WhitespaceBlockTracker {
  WhitespaceBlockTracker(state: Int)
}

pub fn new() -> WhitespaceBlockTracker {
  WhitespaceBlockTracker(0)
}

pub fn state(tracker: WhitespaceBlockTracker) -> Int {
  tracker.state
}

pub fn mark(
  tracker: WhitespaceBlockTracker,
  token: Token,
) -> WhitespaceBlockTracker {
  let state = case token, tracker.state |> int.is_even {
    Whitespace(_), True -> tracker.state
    Whitespace(_), False -> tracker.state * 2
    _, True -> tracker.state * 2 + 1
    _, False -> tracker.state
  }

  WhitespaceBlockTracker(state)
}
