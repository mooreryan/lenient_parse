import data/float/invalid_float_data
import data/float/valid_float_data
import data/integer/invalid_integer_data
import data/integer/valid_integer_data
import gleam/list
import test_data.{type TestData, TestData}

pub fn float_data() -> List(TestData(Float)) {
  [valid_float_data.data(), invalid_float_data.data()]
  |> list.flatten
}

pub fn integer_data() -> List(TestData(Int)) {
  [valid_integer_data.data(), invalid_integer_data.data()]
  |> list.flatten
}
