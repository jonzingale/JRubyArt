require 'matrix'

A = Vector.elements([-1, -3])
B = Vector.elements([-3, 3])
C = Vector.elements([4, 1])

BA, CA = B - A, C - A

def settings
  size(displayWidth/2, displayHeight/2)
end

def setup
  colorMode HSB, 360, 100, 100, 100
  stroke_width 1
  frame_rate 50
  background 0
  @center = Vector.elements([@width/2.0, @height/2.0])
end

def set_vars
	tau, sig = rand, rand
	while (sig + tau > 1)
		sig = rand
	end
	[sig, tau]
end

def barycentric
	sig, tau = set_vars
	pt = A + sig * BA + tau * CA + sig*tau*A
	rPt = rescale(pt)
	ellipse(*rPt, 1, 1)
end

def rescale(pt)
	50 * pt + @center
end

def draw
  stroke (rand 360), 60, 100, 100
	barycentric
end