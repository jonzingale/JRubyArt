require_relative 'epic'

class Grid
  attr_accessor :coords
  def initialize(size, width, height)
    @size = size
    @coords = [*0..size].product([*0..size])
    @x_int = width/size
    @y_int = height/size
    @maths = Epic.new
  end

  def to_grid
    @coords.map do |x, y|
      val = @maths.epis(x+1, y+1)
      rect = [x*@x_int, y*@y_int, x*@x_int + @size, y*@y_int + @size]
      [val, rect]
    end
  end
end

def settings ; size(500, 500) end

def setup
  frame_rate 1;
  background 0
  colorMode(HSB,360,100,100,100)
  @grid = Grid.new(20, @width, @height)
end

# Todo:
# make colored rectangles displaying relative
# number of maps for the upper triangle as
# domain and codomain increase.
# Also:
# test the same for factorial instead of number of maps.

def draw
  them = @grid.to_grid
  them.each do |(val, rec)|
    fill(val % 360,val % 100,val % 10 * 10, 100)
    rect(*rec)
  end
end


