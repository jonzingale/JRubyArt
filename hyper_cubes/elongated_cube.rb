require 'matrix'

BASES = (0...4).map{|i|2**i}.freeze # 1,2,4,8
ALL_POINTS = (0...2**4).inject([],:<<).freeze
REDUCTION = Matrix.rows([[1,0,0,0],[0,1,0,0]]).freeze
TRIANGLES = ALL_POINTS.inject([]){ |a,i| a+=(0...i).map{ |j| [i,j] } }.freeze
EDGES = TRIANGLES.map{|a,b|[a,b] if BASES.include?(a^b)}.compact.freeze
HEXAGONAL = Matrix.rows([[1,0,-1,1],[0.5,1,0.5,1],[0,0,0,1],[0,0,0,1]]).freeze
def trigs(theta) ; %w(cos sin).map{|s| eval("Math.#{s} #{theta}")} ; end

def setup
	size(1450,870) #HOME
	# size(1920,1080) #JackRabbit
	background(20) ; frame_rate 20
	@w,@h = [width,height].map{|i|i/2.0}
	@i = 0 ; @rand_c = (0..2).map{rand(255)} 
end

def tranny
	sin,cos = trigs(@i*2*PI)
	rots_x = Matrix.columns([[cos,sin,0,0],[-sin,cos,0,0],[0,0,1,0],[0,0,0,1]])
	rots_y = Matrix.columns([[cos,0,sin,0],[0,1,0,0],[-sin,0,cos,0],[0,0,0,1]])
	rots_z = Matrix.columns([[cos,0,0,sin],[0,1,0,0],[0,0,1,0],[-sin,0,0,cos]])

	REDUCTION*HEXAGONAL*rots_z*rots_y*rots_x
end

def draw
	@i+=0.003
	no_stroke ; fill(0) ; rect(0,0,width,height)
	[:fill,:stroke].each{|f|send(f,*@rand_c)}

	e_coords = EDGES.map{|a|a.map{|x|("%04d" % x.to_s(2)).split('').map(&:to_i)}}
	turn_edges = e_coords.map{|s|s.map{|v| (tranny*Vector.elements(v)* 150).to_a}}

	translate = turn_edges.map{|edge|edge.map{|e| [e[0]+@w,e[1]+@h] }}
	translate.each{|edge|a,b = edge ; line(*a,*b)}
end
  