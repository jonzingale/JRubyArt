def settings ; size(500, 500) end

def setup
  frame_rate 5 ;
  background 0
  colorMode(HSB,360,100,100,100)
  text_font create_font("word", 25)
end

# Todo:
# make colored rectangles displaying relative
# number of maps for the upper triangle as
# domain and codomain increase.
# Also:
# test the same for factorial instead of number of maps.

def draw
  fill(200,100,100,100)
  rect(0,0,width,height)
end

def fact(n)
  (1..n).inject(1, :*)
end

def choose(n, k)
  fact(n) / (fact(k) * fact(n-k))
end

def epis(d, c)
  (0..c).inject(0) {|a, k| a + (-1)**k * choose(c,k) * (c-k)**d }
end

