#encoding:utf-8
#
# = matrix.rb
# Author:: Hiroyuki Tanaka
# License:: 2-clause BSD (http://www.opensource.org/licenses/bsd-license.php)
#
# Extention of class Matrix in standard ruby library.
#
# The original matrix.rb is..
# Current Maintainer:: Marc-André Lafortune
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

