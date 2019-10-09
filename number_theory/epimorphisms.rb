require_relative 'grid'

def settings ; size(1000, 1000) end

def setup
  frame_rate 1;
  background 0;
  no_stroke;
  colorMode(HSB,360,100,100,100)
  grid = Grid.new(159, 4, @width, @height)
  @scalar = grid.top_value
  @rects = grid.to_grid
end

def draw
  @rects.each do |(val, (x,y,w,h))|
    if val == 0 ; fill 0
    else
      # epimorphisms
      # val = 360 * (val / @scalar)**0.004 # root scale it
      # fill(val % 360, val % 70 + 30, val % 70 + 30)

      # epimorphisms modulo permutations of codomains
      # fill(val % 360, val % 70 + 30, val % 70 + 30)

      # separate colors: epis mod perms
      fill(val % 2 * 180, val % 70 + 30, val % 70 + 30)
    end
    rect(x-100, y-100, w, h)
  end
end
