#encoding:utf-8
#
# = quaternion.rb
# Author:: Hiroyuki Tanaka
# License:: Public Domain

require 'mathlib/matrix'

##
# Class for Quaternion operation.
# A quaternion is formed as 
#   q = {t; x, y, z}
# where +t+ is the scalar part and +x+, +y+ and +z+ are the vector part
# (_xi_ + _yj_ + _zk_).
class Quaternion
  include Math

  ##
  # Returns an object of Quaternion of (t; x, y, z).
  #   q1 = Quaternion.new([1, 2, 3, 4]) # => Quaternion [1; Vector[2, 3, 4]]
  #   q2 = Quaternion.new([2, Vector[3, 4, 5]])
  #     # => Quaternion [2; Vector[3, 4, 5]]
  def initialize array
    raise ArgumentError unless array.is_a?(Array)
    @p = Array.new
    if array.size == 4
      @p[0] = array[0]
      @p[1] = Vector.elements(array[1..3])
    elsif array.size == 2
      raise ArgumentError unless array[1].is_a?(Vector)
      @p[0] = array[0]
      @p[1] = array[1]
    else
      raise ArgumentError
    end
  end

  ##
  # Return an element of +i+.
  #   q = Quaternion.new([1.0, 2.0, 3.0, 4.0])
  #   q[0]  # => 1.0
  #   q[:t] # => 1.0
  #   q[1]  # => 2.0
  #   q[:x] # => 2.0
  #   q[2]  # => 3.0
  #   q[:y] # => 3.0
  #   q[3]  # => 4.0
  #   q[:z] # => 4.0
  #   q[:v] # => Vector[2.0, 3.0, 4.0]
  def [](i)
    case i
    when :t, 0
      @p[0]
    when :x, 1
      @p[1][0]
    when :y, 2
      @p[1][1]
    when :z, 3
      @p[1][2]
    when :v
      @p[1]
    else
      raise ArgumentError
    end
  end

  ##
  # Substitutes to an element. See also Quaternion#[]
  def []=(i, e)
    case i
    when :t, 0
      @p[0] = e
    when :x, 1
      @p[1] = Vector.elements([e, @p[1][1], @p[1][2]])
    when :y, 2
      @p[1] = Vector.elements([@p[1][0], e, @p[1][2]])
    when :z, 3
      @p[1] = Vector.elements([@p[1][0], @p[1][1], e])
    when :v
      if e.is_a?(Array)
        @p[1] = Vector.elements(e)
      elsif e.is_a?(Vector)
        @p[1] = e
      else
        raise ArgumentError
      end
    else
      raise ArgumentError
    end
  end

  ##
  # Compares and returns true iff variables in the two objects are equal.
  def == (other)
    if (@p[0] == other[:t]) && (@p[1] == other[:v])
      true
    else
      false
    end
  end


  ##
  # Multiplies with a Quaternion or a scalar.
  def *(x)
    case x
    when Quaternion
      t = @p[0]*x[:t] - @p[1].inner_product(x[:v])
      v = x[:v]*@p[0] + @p[1]*x[:t] + @p[1].cross_product(x[:v])

      Quaternion.new([t, v])
    when Numeric
      t = @p[0]*x
      v = @p[1]*x

      Quaternion.new([t, v])
    else
      raise ArgumentError
    end
  end

  ##
  # Divides with a scalar
  def /(x)
    case x
    when Numeric
      t = @p[0]/x
      v = @p[1]/x

      Quaternion.new([t, v])
    else
      raise ArgumentError
    end
  end

  ##
  # Returns string format of an object.
  def inspect
    "Quaternion [#{@p[0].to_s}; #{@p[1].to_s}]"
  end
  alias to_s inspect

  ##
  # Returns a conjugate of an object.
  def conjugate
    Quaternion.new([@p[0], -@p[1]])
  end

  ##
  # Returns magnitude of a quaternion.
  #  q = Quaternion.new([1, 1, 3, 5])
  #  q.magnitude # => 6.0
  def magnitude
    qr = self*(self.conjugate)
    sqrt(qr[0])
  end
  alias norm magnitude

  ##
  # Returns normalized Quaternion
  def normalize
    m = self.magnitude
    self/m
  end
end
