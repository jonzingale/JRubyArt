def settings
  size(displayWidth, displayHeight)
end

def setup
  @w, @h = [width/2,height/2] # center point
  frame_rate 135
  background 0
end

def update_variables
  @t = @t ? (@t+=1) % 360 : 0
  @cos, @sin = %w(sin cos).map{|s| Math.send(s, @t) }
  @r = rand 40
end

def grassland
  r = rand 30 + @t
  g = rand 255 * @cos
  b = rand 255 * @sin
  fill(r,g,b) ; strokeWeight(0.3) ; stroke((r*g*b)%255)

  lit = rand(width/2)
  boots = [lit,height-lit,rand(lit),rand(@h),rand(width),rand(height),width-lit,height-rand(200)]
  noFill; stroke(rand(5)+lit, rand(30)+lit, rand(255), 220)
  bezier(*boots)
end

def draw
  update_variables

  ##sun
  fill(255,90,0,30)
  ellipse(width-200,@h-300,@r*10,@r*10)

  # suns
  strokeWeight(rand 20)
  stroke(0,0,0,rand(255))
  ellipse(@w*@sin, @h*@cos-200, @r*10, @r*10)

  grassland
end
