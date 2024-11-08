import gleam/queue
import lenient_parse/internal/scale.{by_10}
import startest/expect

pub fn scale_test() {
  let a = queue.from_list([1, 2, 3])
  let b = queue.from_list([4, 5, 6])

  let #(a, b) = by_10(a, b, 1)

  a |> queue.to_list |> expect.to_equal([1, 2, 3, 4])
  b |> queue.to_list |> expect.to_equal([5, 6])

  let #(a, b) = by_10(a, b, 1)

  a |> queue.to_list |> expect.to_equal([1, 2, 3, 4, 5])
  b |> queue.to_list |> expect.to_equal([6])

  let #(a, b) = by_10(a, b, 1)

  a |> queue.to_list |> expect.to_equal([1, 2, 3, 4, 5, 6])
  b |> queue.to_list |> expect.to_equal([])

  let #(a, b) = by_10(a, b, 1)

  a |> queue.to_list |> expect.to_equal([1, 2, 3, 4, 5, 6, 0])
  b |> queue.to_list |> expect.to_equal([])

  let #(a, b) = by_10(a, b, -3)

  a |> queue.to_list |> expect.to_equal([1, 2, 3, 4])
  b |> queue.to_list |> expect.to_equal([5, 6, 0])

  let #(a, b) = by_10(a, b, -4)

  a |> queue.to_list |> expect.to_equal([])
  b |> queue.to_list |> expect.to_equal([1, 2, 3, 4, 5, 6, 0])

  let #(a, b) = by_10(a, b, -3)

  a |> queue.to_list |> expect.to_equal([])
  b |> queue.to_list |> expect.to_equal([0, 0, 0, 1, 2, 3, 4, 5, 6, 0])
}