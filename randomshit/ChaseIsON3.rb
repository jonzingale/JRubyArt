def settings
  size(displayWidth, displayHeight)
end
def setup
  text_font create_font("SanSerif",60);
  # colorMode(HSB,360,100,100,100) # for future experimentation
  background(10)
  frame_rate 30
  fill 2.8, 2.6
  smooth
  @t=1
end

def trigs(theta)#:: Theta -> R2
  @cos,@sin = %w(sin cos).map{|s| eval("Math.#{s} #{theta}")}
end

def rootsUnity(numbre)#::Int -> [trivalStar]
  (0...numbre).map{|i|[Math.cos(i*2*PI/numbre),Math.sin(i*2*PI/numbre)]}
end

def dist(a,b,c,d)#::(Coord,Coord)->(Coord,Coord)-> Real
  Math.sqrt((c-a)**2+(d-b)**2)
end

###########
def walker_z(p=width/2,q=height/2) # Follows mouse
  kick = [0,0,0,90] ; snare = (1..3).map{|i|rand(255)}+[rand(60)+10]
  [snare,kick,snare,snare,kick].each do |s1,s2,s3,w|
    stroke(s1,s2,s3,w) ; strokeWeight(w)

    signs = rootsUnity(17).map{|n|i,j=n; [1*i,1*j]}
    p , q = (@wz1.nil? ? [p,q] : [@wz1,@wz2])
    pair2 = [mouseX,mouseY]

    pairs = signs.map{|i,j| [p+i,q+j,*pair2] }
    min_p = pairs.min_by{|pt|dist(*pt)}[0,2]
    max_p = pairs.max_by{|pt|dist(*pt)}[0,2]
    low = pairs.map{|pt|dist(*pt)}.min

    @wz1, @wz2 = low <= 10 || low >= 30 ? min_p : max_p
    point(@wz1, @wz2)
  end
end

###########
def walker_y(p=width/2,q=height/2) # Follower
  kick = [0,0,0,90] ; snare = (1..3).map{|i|rand(255)}+[rand(60)+10]
  [snare,kick,snare,snare,snare].each do |s1,s2,s3,w|
    stroke(s1,s2,s3,w) ; strokeWeight(w)

    signs = rootsUnity(10).map{|n|i,j=n; [2*i,2*j]}
    p , q = (@wy1.nil? ? [p,q] : [@wy1, @wy2])
    pair2 = (@wx1.nil? ? [6,0] : [@wx1, @wx2])

    pairs = signs.map{|i,j| [p+i ,q+j, *pair2] }
    min_p = pairs.min_by{|pt|dist(*pt)}[0,2]
    max_p = pairs.max_by{|pt|dist(*pt)}[0,2]
    low = pairs.map{|pt|dist(*pt)}.min

    @wy1, @wy2 = low <= 10 || low >= 30 ? min_p : max_p
    point(@wy1, @wy2)
  end
end

def walker_x(p=width/4,q=height/2) # Leader
  kick = [0,0,0,70] ; snare = (1..3).map{|i|rand(255)}+[rand(30)]
  [snare,kick,snare,snare,snare].each do |s1,s2,s3,w|
    stroke(s1,s2,s3,w) ; strokeWeight(w)

    signs =  [[1,1],[-1,-1],[-1,1],[1,-1]]
    pair1 = (@wy1.nil? ? [50,0]: [@wy1,@wy2])
    p , q = (@wx1.nil? ? [p,q]  : [@wx1,@wx2])

    pairs = signs.map{|i,j| [*pair1,i+p,j+q] }
    min_p = pairs.min_by{|pt|dist(*pt)}[0]
    max_p = pairs.max_by{|pt|dist(*pt)}[0]
    low = pairs.map{|pt|dist(*pt)}.min

    # to keep this guy ahead
    k = (low <= 100 ? 7 : low > 300 ? 3 : 4)
    point(@wx1=(p-(k*rand-0.5))%width,@wx2=(q-(k*rand-0.5))%height)
  end
end

def pentagram
  roots = rootsUnity(5).map{|n|i,j=n; [100*i,100*j]}
  l,m =roots.shuffle.take(2)
  line(l[0]+700,l[1]+700,m[0]+700,m[1]+700)
end

def bezierLand
  x, y = [width/2,height/2] # center point
  g, b = [@t*2,@t*2.1] #greens blues
  @t = (@t+=1) % width # modular_index
  cos, sin = trigs(@t)

  r = rand(30) + @t
  g = rand(200*@cos)
  b = rand(300*@sin)
  stroke(r,g,b)

  roots = rootsUnity(6).shuffle
  b_points = roots.flatten.take(8)

  strokeWeight(0.2) # quiet reds
  beez = b_points.shuffle.map{|i|y-400*i}
  bezier(*beez)

  strokeWeight(2.2)
  beez = b_points.map{|i|width-400*i}
  bezier(*beez)

  # line coods
  a,b,c,d,e,f,g,h = b_points
  r,t = [a,c].map { |i| height - i*rand(300) }
  q,s = [b,d].map { |i| i*rand(800) }
  line(width-q,height-r,width-s,height-t)

  pentagram
end

def draw
  walker_y ; walker_x # dots chasing one another.
  walker_z # dot chasing mouse
  bezierLand
end
