# Changelog

## v1.2.0 - 2024-10-20

- Fixed bugs.
- Reworked internal algorithm for more robust parsing.
- Breaking change: `InvalidCharacter`, `InvalidUnderscorePosition`, `InvalidDecimalPosition`, and `InvalidSignPosition` now also contain an index that points to the position in the original string where the error occurred.
- Breaking change: `WhitespaceOnlyOrEmptyString` no longer exists and has been replaced by `EmptyString` and `WhitespaceOnlyString`.

## v1.0.1 - 2024-10-10

- Added more examples to `README.md`.

## v1.0.0 - 2024-10-10

- Initial release.
