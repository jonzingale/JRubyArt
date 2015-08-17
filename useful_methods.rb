# sprinkle over torus
# random walk the radius R
require 'matrix'
	def setup
		frame_rate 7
		size(800,800)
		@w,@h = [400] * 2
		@i, @j, @t = [0] * 3

		colorMode(HSB,360,100,100)
		text_font create_font("SanSerif",10)

		background(0)
		@all_coords = (0..3000).map{ sprinkle }
		@all_diagonals = (0..500).map{ sprinkle_diag }
	end

	def sin_cos(var) ; %w(sin cos).map {|s| Math.send(s, 2 * PI * var) } ; end

	cos,sin = %w(cos sin).map{|s| eval("Math.#{s} #{(@i += 0.004)*PI}")}
	
	def abs(i) ; ((i**2)**0.5).to_f ; end

	def text_block(string='')
		fill(0,0,0)
		rect(90,80,200,40)
		fill(200, 140, 100)
		text(string,100,100)
	end

	def trigs(theta)#:: Theta -> R2
	  %w(cos sin).map{|s| eval("Math.#{s} #{theta}")}
	end

	def rootsUnity(numbre)#::Int -> [trivalStar]
		(0...numbre).map{|i|trigs(i*2*PI/numbre)}
	end

	def rgb_converter(m=0,n=0)
		k = get(m,n)
		r = 256 + k/(256**2)
		g = k/256 % 256
		b = k % 256
		[r,g,b]
	end

	def all_pairs(height,width)
		(0...height).inject([]){|a,h|a + (0...width).map{|w|[w,h]} }
	end