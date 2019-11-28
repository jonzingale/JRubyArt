def settings
  size(displayWidth/2, displayHeight/2)
end
def setup
  text_font create_font("SanSerif",60);
  background(10)
  frame_rate 30
  fill 2.8, 2.6
  @walker_y = Walker.new(width, height)
  @walker_x = Walker.new(width, height, @walker_y)
  smooth
  @t=1
end

def trigs(theta)#:: Theta -> R2
  @cos,@sin = %w(sin cos).map{|s| eval("Math.#{s} #{theta}")}
end

def rootsUnity(numbre)#::Int -> [trivalStar]
  (0...numbre).map{|i|[Math.cos(i*2*PI/numbre),Math.sin(i*2*PI/numbre)]}
end

def diff(w)#::(Coord,Coord)->(Coord,Coord)-> Real
  w1,w2 = w ; a,b = w1 ; c,d = w2
  x = (c-a)**2 ; y = (d-b)**2
  Math.sqrt(x+y)
end

###########
# TODO: Creating a walker class is right, but I do need to think
# about what kinds of interactions ought to be baked in. When is
# one a chaser and another a chasee. How do they know about each other?
class Walker
  attr_accessor :pt, :qt
  def initialize(width, height, chaser=nil)
    @chaserPts = chaser ? [chaser.pt, chaser.qt] : [50,0]
    @width, @height = width, height
    @wx1, @wx2 = 50, 0
    @pt , @qt = 50, 0
  end

  def time(t)
    @t=t
  end

  def diff(a,b,c,d)#::(Coord,Coord)->(Coord,Coord)-> Real
    x = (c-a)**2
    y = (d-b)**2
    Math.sqrt(x+y)
  end

  def walk
    kick = [0,0,0,70]
    snare = (0..2).map { |i| rand(255) } + [rand(30)]
    signs = [[1,1],[-1,-1],[-1,1],[1,-1]]

    # [snare,kick,snare,snare,snare]
    [snare].map do |s1,s2,s3,w|
      stroke(s1,s2,s3,w)
      strokeWeight(w)

      pairs = signs.map { |i, j| [*@chaserPts, i+@pt, j+@qt] }
      min_p = pairs.min_by { |pt| diff(*pt) }[1]
      max_p = pairs.max_by { |pt| diff(*pt) }[1]
      low = pairs.map{|pt|diff(*pt)}.min

      # # to keep this guy ahead
      k = (low <= 100 ? 7 : low > 300 ? 3 : 4)
      @wx1=(@pt-(k*rand-0.5)) % @width
      @wx2=(@qt-(k*rand-0.5)) % @height
      point(@wx1, @wx2)
    end
  end
end

def walker_z(t,p=width/2,q=height/2) # Follows mouse
  kick = [0,0,0,90] ; snare = (1..3).map{|i|rand(255)}+[rand(60)+10]
  [snare,kick,snare,snare,snare].map do |b|
    s1,s2,s3,w = b ; stroke(s1,s2,s3,w) ; strokeWeight(w)

    signs = rootsUnity(17).map{|n|i,j=n; [1*i,1*j]}
    p , q = (@wz1.nil? ? [p,q] : [@wz1,@wz2])
    pair2 = [mouseX,mouseY]

    pairs = signs.map{|s| i,j=s;[[p+i,q+j],pair2] }
    min_p = pairs.min_by{|p|diff(p)}[0]
    max_p = pairs.max_by{|p|diff(p)}[0]
    low = pairs.map{|p|diff(p)}.min

    p,q = (low <= 10 ? max_p : low >= 30 ? min_p : max_p)
    point(@wz1=p,@wz2=q)
  end
end

###########
def walker_y(t,p=width/2,q=height/2) # Follower
  kick = [0,0,0,90] ; snare = (1..3).map{|i|rand(255)}+[rand(60)+10]
  [snare,kick,snare,snare,snare].map do |b|
    s1,s2,s3,w = b ; stroke(s1,s2,s3,w) ; strokeWeight(w)

    signs = rootsUnity(10).map{|n|i,j=n; [2*i,2*j]}
    p , q = (@wy1.nil? ? [p,q] : [@wy1,@wy2])
    pair2 = (@wx1.nil? ? [6,0] : [@wx1,@wx2])

    pairs = signs.map{|s| i,j=s;[[p+i,q+j],pair2] }
    min_p = pairs.min_by{|p|diff(p)}[0]
    max_p = pairs.max_by{|p|diff(p)}[0]
    low = pairs.map{|p|diff(p)}.min

    p,q = (low <= 10 ? max_p : low >= 30 ? min_p : max_p)
    point(@wy1=p,@wy2=q)
  end
end

def pentagram
  roots = rootsUnity(5).map{|n|i,j=n; [100*i,100*j]}
  l,m =roots.shuffle.take(2)
  line(l[0]+700,l[1]+700,m[0]+700,m[1]+700)
end

def draw
  x,y = [width/2,height/2] # center point
  g,b = [@t*2,@t*2.1] #greens blues
  @t = (@t+=1) % width # modular_index
  cos,sin = trigs(@t)

  # dots chasing one another.
  @walker_x.walk
  walker_y(@t)
  # dot chasing mouse
  walker_z(@t)
  ###

###bezier land
  r = rand(30) + @t
  g = rand(200*@cos)
  b = rand(300*@sin)
  stroke(r,g,b)

  roots = rootsUnity(6).shuffle
  b_points = roots.inject([]){|js,i| js+i }

  strokeWeight(0.2) # quiet reds
  a,b,c,d,e,f,g,h = b_points.shuffle.map{|i|y-400*i}
  bezier(a,b,c,d,e,f,g,h)

  strokeWeight(2.2)
  a,b,c,d,e,f,g,h = b_points.map{|i|width-400*i}
  bezier(a,b,e,f,c,d,g,h)

  # line coods
  a,b,c,d,e,f,g,h = b_points.map{|i|1*i}
  r,t = [a,c].map{|i| height - i*rand(300)}
  q,s = [b,d].map{|i| i*rand(800)}
  line(width-q,height-r,width-s,height-t)

  pentagram
end
