require 'test/unit'
require 'matrix/matrix'

class TestMatrix < Test::Unit::TestCase
  def setup
    @m1 = Matrix[[1, 2, 3], [4, 5, 6]]
  end

  def test_add_columns
    expected = Matrix[[1, 2, 3, 7], [4, 5, 6, 8]]

    assert_equal(expected, @m1.add_columns(Matrix[[7], [8]]))
    assert_raise(ArgumentError) { @m1.add_columns(Matrix[[7, 8]]) }
  end

  def test_add_columns!
    m = Matrix[[1, 2], [4, 5]]
    m.add_columns!(Matrix[[3], [6]])

    assert_equal(@m1, m)
  end

  def test_add_rows
    expected = Matrix[[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    assert_equal(expected, @m1.add_rows(Matrix[[7, 8, 9]]))
    assert_raise(ArgumentError) { @m1.add_rows(Matrix[[7, 8]]) }
  end

  def test_add_rows!
    m = Matrix[[1, 2, 3]]
    m.add_rows!(Matrix[[4, 5, 6]])

    assert_equal(@m1, m)
  end
end