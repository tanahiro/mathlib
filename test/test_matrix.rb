require "minitest/autorun"
require "mathlib/matrix"

class TestMatrix < MiniTest::Unit::TestCase
  def setup
    @m1 = Matrix[[1, 2, 3], [4, 5, 6]]
  end

  def test_add_columns
    expected = Matrix[[1, 2, 3, 7], [4, 5, 6, 8]]

    assert_equal(expected, @m1.add_columns(Matrix[[7], [8]]))
    assert_raises(ArgumentError) { @m1.add_columns(Matrix[[7, 8]]) }
  end

  def test_add_columns!
    m = Matrix[[1, 2], [4, 5]]
    m.add_columns!(Matrix[[3], [6]])

    assert_equal(@m1, m)
  end

  def test_add_rows
    expected = Matrix[[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    assert_equal(expected, @m1.add_rows(Matrix[[7, 8, 9]]))
    assert_raises(ArgumentError) { @m1.add_rows(Matrix[[7, 8]]) }
  end

  def test_add_rows!
    m = Matrix[[1, 2, 3]]
    m.add_rows!(Matrix[[4, 5, 6]])

    assert_equal(@m1, m)
  end
end

class TestVector < MiniTest::Unit::TestCase
  def setup
    @v1 = Vector[1.0, 3.0, 5.0]
    @v2 = Vector[-2.0, 6.0, 4.0]
    @v3 = Vector[1.0, 1.0]
  end

  def test_cross_product
    expected = Vector[-18.0, -14.0, 12.0]

    assert_equal(expected, @v1.cross_product(@v2))
    assert_raises(Vector::ErrDimensionMismatch) { @v1.cross_product(@v3) }
    assert_raises(Vector::ErrDimensionMismatch) { @v3.cross_product(@v1) }
  end
end
