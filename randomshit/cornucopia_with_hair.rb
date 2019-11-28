# Spirals cause Jake asked for them.
R = 100.freeze
def settings
  size(displayWidth/1.3, displayHeight/1.3)
end
def setup
	text_font create_font("SanSerif",60);
	background(10)
  frame_rate 40
  fill 2.8, 2.6
  smooth
  @t=1 ; @dex = 1; @rex = 1
  @onstate = 1
end

def trigs(theta)#:: Theta -> R2
  @cos,@sin = %w(sin cos).map{|s| eval("Math.#{s} #{theta}")}
end

def rootsUnity(numbre)#::Int -> [trivalStar]
	(0..numbre-1).map{|i|[Math.cos(i*PI/numbre),Math.sin(i*PI/numbre)]}
end

def diff(w)#::(Coord,Coord)->(Coord,Coord)-> (N,N)
	w1,w2 = w ; a,b = w1 ; c,d = w2
	[a-c,b-d].map(&:abs)
end

def walker_y(t,a=0) # index->attraction->point
	kick = [0,0,0,200] ; snare = (1..3).map{|i|rand(255)}+[rand(100)]
 [kick,snare].map do |b|
 		s1,s2,s3,w = b ; stroke(s1,s2,s3,w) ; strokeWeight(w)
 		pair = [[-@t%width,height/2],[@t+a,(@t+a)/3]]
 		pair2 = [[@t%width,-height/2],[@t+a,(@t+a)/3]]
 		closer = [diff(pair),diff(pair2)].min
 		farther = [diff(pair),diff(pair2)].max

 		p,q = (a%height < 10 ? farther : a%height > 100 ? closer : nil)
 		point(@t+p,(@t+q)/3)
 end
end

def walker_x(t,a=0)
	kick = [0,0,0,40] ; snare = (1..3).map{|i|rand(255)}+[rand(30)]
 [kick,snare].map do |b|
 		s1,s2,s3,w = b ; stroke(s1,s2,s3,w) ; strokeWeight(w)
 		
 		pair = [[-@t%width,height/2],[@t+a,(@t+a)/3]] 		
 		pair2 = [[@t%width,-height/2],[@t+a,(@t+a)/3]] 		
 		closer = [diff(pair),diff(pair2)].min 		
 		farther = [diff(pair),diff(pair2)].max
 		p,q = (a%height < 10 ? farther : a%height > 100 ? closer : nil)
 		point(p,q)

 		point(-@t%width,height/2)
 end
end

def draw
	x,y = [width/2,height/2] # center point
	g,b = [@t*2,@t*2.1] #greens blues
	@t = (@t+=1) % width # modular_index

	# fill(color(rand(255),g,b))
	cos,sin = trigs(@t)

# two dots get near, attract and then repel
walker_y(@t) ; walker_x(@t)

#

###bezier land
	r = rand(30) + @t
	g = rand(200*@cos)
	b = rand(300*@sin)
	stroke(r,g,b)

	roots = rootsUnity(5).shuffle
	b_points = roots.inject([]){|js,i| js+i }
	a,b,c,d,e,f,g,h = b_points.shuffle
	bezier(a,b,c,d,e,f,g,h);

	# line coods
	strokeWeight(0.5)
	r,t = [a,c].map{|i| height - i*rand(300)}
	q,s = [b,d].map{|i| i*rand(800)}
	line(q,r,s,t)

	@onstate *= -1 if @t==0
	if @onstate == -1
		good3 = [a, 500, 250,b,250, 0,e,500]
		b_points = good3.map{|d|d+y}
		bezier(*b_points.shuffle); # strange bezier box
	end
# ###bezier

	text_font create_font("SanSerif",60);
	text("Jake ! ! !" ,rand(@cos)+x,rand(@sin)+y )
	strokeWeight(rand(30));

## make spiral here.
# r increases like 100
	text_font create_font("SanSerif",20);
	text("Jake" ,x+@cos*@t,@t*R*@sin+x)
	text('ZER0',width - (x/4),height - (y/4))

	#########
	wd,ht = [width/2,height/2]
	fill(color(rand(@rex) % 255, @t ,rand(55)+100))

	it = rand(100)
	(1..it).map do |i| # happy star
		# colorMode(RGB,255)
		stroke(rand(255),rand(255),rand(255))
		cs,sn = [Math.cos(i*PI/it),Math.sin(i*PI/it)]
		@t += 1; text(@t,wd-100,ht-100)
		strokeWeight(rand(30));


		point(wd+(200+i)*cs,ht+(200+i)*sn)
	end

	stroke(rand(255))
	# circle about it
	cs,sn = [Math.cos(@t*2*PI/height),Math.sin(@t*2*PI/height)]
	point(wd+cs*100,ht+sn*100)

	#line across it
@dex +=10 if @t==0 ;	@t += 1 
	point(@t+@dex % width,@t % height)

	# text numbers black
	[rand(255),0].map{|n| fill(n,n,n) ; text(@t,wd-100,ht-100)}

end

