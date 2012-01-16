require "minitest/autorun"
require "mathlib/matrix"
require "mathlib/quaternion"

class TestQuaternion < MiniTest::Unit::TestCase
  def setup
    @q1 = Quaternion.new([1.0, 2.0, 3.0, 4.0])
  end

  def test_initialize
    q1 = Quaternion.new([1.0, 2.0, 3.0, 4.0])
    q2 = Quaternion.new([1.0, Vector[[2.0, 3.0, 4.0]]])
    assert_instance_of(Quaternion, q1)
    assert_instance_of(Quaternion, q2)

    assert_raises(ArgumentError) {Quaternion.new()}
    assert_raises(ArgumentError) {Quaternion.new(1.0)}
    assert_raises(ArgumentError) {Quaternion.new(1.0, 2.0, 3.0, 4.0)}
    assert_raises(ArgumentError) {Quaternion.new([1.0, 2.0])}
  end

  def test_bracket
    assert_equal(1.0, @q1[0])
    assert_equal(1.0, @q1[:t])
    assert_equal(2.0, @q1[1])
    assert_equal(2.0, @q1[:x])
    assert_equal(3.0, @q1[2])
    assert_equal(3.0, @q1[:y])
    assert_equal(4.0, @q1[3])
    assert_equal(4.0, @q1[:z])
    assert_equal(Vector.elements([2.0, 3.0, 4.0]), @q1[:v])
    assert_raises(ArgumentError) {@q1[4]}
  end

  def test_substitute
    q1 = Quaternion.new([5.0, 6.0, 7.0, 8.0])
    q2 = Quaternion.new([1.0, 6.0, 7.0, 8.0])

    q1[:t] = 1.0
    q1[:x] = 2.0
    q1[:y] = 3.0
    q1[:z] = 4.0
    assert_equal(@q1, q1)

    q1[:v] = [6.0, 7.0, 8.0]
    assert_equal(q2, q1)
    q1[:v] = Vector[2.0, 3.0, 4.0]
    assert_equal(@q1, q1)
  end

  def test_equal
    q1 = Quaternion.new([1.0, 2.0, 3.0, 4.0])
    assert_operator(q1, :==, @q1)
    q1 = Quaternion.new([0.0, 2.0, 3.0, 4.0])
    refute(q1 == @q1)
    q1 = Quaternion.new([1.0, 1.0, 3.0, 4.0])
    refute(q1 == @q1)
  end

  def test_multiply
    q2 = Quaternion.new([2.0, 4.0, 6.0, 8.0])
    assert_equal(q2, @q1*2.0)

    q2 = Quaternion.new([2.0, 3.0, 4.0, 5.0])
    q3 = Quaternion.new([-36.0, 6.0, 12.0, 12.0])
    assert_equal(q3, @q1*q2)

    assert_raises(ArgumentError) {@q1*"1.0"}
  end

  def test_division
    q = Quaternion.new([2.0, 4.0, 6.0, 8.0])
    assert_equal(@q1, q/2.0)

    assert_raises(ArgumentError) {@q1/"1.0"}
  end

  def test_inspect
    str = "Quaternion [1.0; Vector[2.0, 3.0, 4.0]]"
    assert_equal(str, @q1.inspect)
  end

  def test_conjugate
    q = Quaternion.new([1.0, -2.0, -3.0, -4.0])
    assert_equal(q, @q1.conjugate)
  end

  def test_magnitude
    q = Quaternion.new([1, 1, 3, 5])
    assert_equal(6.0, q.magnitude)
  end

  def test_normalize
    q1 = Quaternion.new([1, 1, 3, 5]).normalize
    assert_in_delta(1.0/6.0, q1[:t])
    assert_in_delta(1.0/6.0, q1[:x])
    assert_in_delta(3.0/6.0, q1[:y])
    assert_in_delta(5.0/6.0, q1[:z])
  end

end
