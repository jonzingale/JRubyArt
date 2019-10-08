require_relative 'epic'

class Grid
  attr_accessor :coords
  def initialize(size, width, height)
    @size = size
    @coords = [*0..size].product([*0..size])
    @x_int, @y_int = [width/size, height/size]
    @maths = Epic.new
  end

  def to_grid
    @coords.map do |x, y|
      val = @maths.epis(x, y)
      rect = [x*@x_int, y*@y_int, x*(@x_int + @size), y*(@y_int + @size)]
      [val, rect]
    end
  end
end

def settings ; size(1800, 1000) end

def setup
  frame_rate 1;
  background 0
  colorMode(HSB,360,100,100,100)
  @grid = Grid.new(100, @width, @height)
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
    if val == 0
      fill(val % 100,100,0,0)
    else
      fill(val % 360,val % 100,val % 100,100)
      # fill(val % 100,100,100,100)
    end
    rect(*rec)
  end
end
