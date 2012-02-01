#encoding:utf-8
#
# = matrix.rb
# Author:: Hiroyuki Tanaka
# License:: 2-clause BSD (http://www.opensource.org/licenses/bsd-license.php)
#
# Extension of class Matrix in standard ruby library.
#
# The original matrix.rb is..
# Current Maintainer:: Marc-Andre Lafortune
# Original Author:: Keiju ISHITSUKA
# Original Documentation:: Gavin Sinclair (sourced from <i>Ruby in a Nutshell</i> (Matsumoto, O'Reilly))
##

require 'matrix'

##
# Extends class Matrix.
class Matrix
  ##
  # Returns a matirx that +columns+ are added to the right side of a matrix
  #   m = Matrix[[1, 2, 3], [4, 5, 6]]
  #   m.add_columns(Matrix[[7], [8]])
  #     => 1 2 3 7
  #        4 5 6 8
  def add_columns *columns
    matrix_a = self.to_a

    columns.each {|m|
      if m.row_size != self.row_size
        raise ArgumentError, "number of rows should be identical"
      end

      m_a = m.to_a
      m_a.each_with_index {|i, k|
        i.each {|j|
          matrix_a[k] << j
        }
      }
    }

    Matrix.rows(matrix_a)
  end

  ##
  #  Adds columns to a matrix. See Matrix#add_columns
  def add_columns! *columns
    matrix_new = add_columns *columns
    @rows = matrix_new.to_a
    @column_size = @rows[0].size
  end

  ##
  # Returns a matirx that +rows+ are added to the bottom side of a matrix
  #   m = Matrix[[1, 2, 3], [4, 5, 6]]
  #   m.add_columns(Matrix[[7, 8, 9]])
  #     => 1 2 3
  #        4 5 6
  #        7 8 9
  def add_rows *rows
    matrix_a = self.to_a

    rows.each {|m|
      if m.column_size != self.column_size
        raise ArgumentError, "number of columns should be identical"
      end

      matrix_a += m.to_a
    }

    Matrix.rows(matrix_a)
  end

  ##
  # Adds +rows+ to a matrix. See also Matrix#add_rows
  def add_rows! *rows
    matrix_new = add_rows *rows
    @rows = matrix_new.to_a
  end
end

##
# Extends Vector class
class Vector
  ##
  # Calculates cross products. Size of vector should be 3.
  def cross_product x
    Vector.Raise ErrDimensionMismatch if size != 3
    Vector.Raise ErrDimensionMismatch if x.size != 3

    c = Array.new

    c[0] = @elements[1]*x[2] - @elements[2]*x[1]
    c[1] = @elements[2]*x[0] - @elements[0]*x[2]
    c[2] = @elements[0]*x[1] - @elements[1]*x[0]

    Vector.elements(c)
  end

  ##
  # Retunrs negated vector
  #  -Vector[1.0, 1.0, 1.0] # => Vector[-1.0, -1.0, -1.0]
  def -@
    map(&:-@)
  end

  ##
  # Checks the direction of the two vectors.
  # Returns 1 if the direction is same, -1 if the direction is opposite,
  # othrewise 0.
  #  Vector[1.0, 2.0, 3.0].direction?(Vector[2.0, 4.0, 6.0]) # => 1
  #  Vector[1.0, 2.0, 3.0].direction?(Vector[-2.0, -4.0, -6.0]) # => -1
  #  Vector[1.0, 2.0, 3.0].direction?(Vector[1.0, 3.0, 7.0]) # => 0
  def direction? x
    var1 = self.inner_product(x)
    var2 = self.r*x.r/var1

    if (1.0 - var2.abs).abs < 1.0e-15
      if var2 > 0
        return 1
      else
        return -1
      end
    else
      return 0
    end
  end
end

