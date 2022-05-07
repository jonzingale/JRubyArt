require 'matrix'
BASES = (0...4).map{|i|2**i}.freeze # 1,2,4,8
ALL_POINTS = (0...2**4).inject([],:<<).freeze

def settings ; size(displayWidth/2, displayHeight/2) ; end

def setup
  background(20) ; frame_rate 40
	@w, @h, @i, @rand_c = [width/2.0, height/2.0, 0, (0..2).map{rand(255)}]
	triangles = ALL_POINTS.inject([]){ |a,i| a+=(0...i).map{ |j| [i,j] } }.freeze
	edges = triangles.map{|a,b|[a,b] if BASES.include?(a^b)}.compact.freeze
	@coords = edges.map{|a|a.map{|x|("%04d" % x.to_s(2)).split('').map(&:to_i)}}
	[:fill,:stroke].each{|f|send(f,*@rand_c)}
end

def draw
	clear ; cos,sin = %w(cos sin).map{|s| eval("Math.#{s} #{(@i+=0.001)*2*PI}")}
	rotation = Matrix.rows([[cos**2,cos*sin,-sin,0],[-cos*sin,cos**2,0,-sin]])

	transform_edges = [0,1].map do |i|
		(rotation*Matrix.columns(@coords.transpose[i])* height/4.0).transpose.to_a
	end.transpose

	transform_edges.each do |edge|
		a, b = edge.map { |d, e| [d+@w, e+@h]}
		line(*a,*b)
	end
end
