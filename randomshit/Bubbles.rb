# Triangles gone wild
def settings ; size(displayWidth/2, displayHeight/2) ; end

def setup
  background 10
  frame_rate 30
  fill 2.8, 2.6
  smooth
end

def mask
	fill(0,0,0,8)
	rect(0,0,width,height)
end

def content
	i, *t = [27,61,3,8,56,2,45,1,1].shuffle.unshift(1)

	# green meanie
	newcolor = color rand(3)*t[1],rand(t[2])+100,rand(55)
	fill newcolor
	b1 = 180*i + width/(rand(10)+1) # stretch
	b2 = 200 * rand(0)
	bezier(b1, b2, 81, 81, 89, 89, 15, 80)

	# big blue
	(1..8).each do
		newcolor = color rand(i+t[1]+t[2]), rand(25)+100, rand(55)+100
		fill newcolor

		b1 = 8 * i
		b2 = 8 * rand(8)
		b3 = height/2+81*t[0]%40
		b4 = 81+t[3]
		bezier(b1, b2, b3, b4, 890, 890, 815, 880)
	end

	newcolor = color rand(255), rand(25)+100, rand(55)+100
	fill newcolor
	a, b, c = (1..3).map {|i| rand(3)}
	xx = 30 + width/2
	yy = (a+30+b**2)**c % 400 + height/2
	xr = 20+rand(100)
	yr = 50
	ellipse(xx, yy, xr, yr)

	newcolor = color(rand(25)+0,rand(25)+100,rand(55)+100)
	fill newcolor
	ellipse(rand(width),rand(height),rand(width)/20,rand(height)/20)
end

def draw
	mask
	content
end