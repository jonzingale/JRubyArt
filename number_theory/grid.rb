# require 'byebug'
require_relative 'epic'

class Grid
  attr_accessor :coords
  def initialize(num, size, width, height)
    @num = num
    @size = size
    @coords = [] ; get_coords
    @x_int, @y_int = [width/size, height/size]
    @maths = Epic.new
  end

  def get_coords
    [*0..@num].each { |x| [*0..x].each {|y| @coords << [x, y]} }
  end

  def top_value
    # keep for epis and epis mod fact codomain
    val = @coords.map { |x, y| @maths.epis(x, y) }.max.to_f

    # val = @coords.map { |x, y| @maths.choose(x, y) }.max.to_f

    # monics and monsters, reversed coords cause yeah.
    # val = @coords.map { |x, y| @maths.monics(y, x) }.max.to_f
    # val = @coords.map { |x, y| @maths.monster(y, x) }.max.to_f
  end

  def to_grid
    @coords.map do |x, y|
      val = @maths.epis(x, y)
      # val = @maths.epis(x, y) / @maths.fact(y)

      # val = @maths.choose(x, y)

      # monics and monsters, reversed coords cause yeah.
      # val = @maths.monics(y, x) # these get fast too quick
      # val = @maths.monster(y, x) # these are likely always zero

      rect = [@x_int + x*@size, @y_int + y*@size, @size, @size]
      [val, rect]
    end
  end
end

# it = Grid.new(5, 10, 100, 100)
# it.get_coords

# byebug
# 3
