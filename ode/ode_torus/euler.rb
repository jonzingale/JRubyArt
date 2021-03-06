module Torus
	include Math
	Tau = 2 * PI
	RAD = 0.5 # 0, 1, 2
	SCALE = 450 / (1 + RAD) # incorporate rotations

	def sin_cos(var)
		[:sin, :cos].map {|s| send(s, Tau * var) }
	end

	def to_torus(x,y)
		sin_p, cos_p = sin_cos x
		sin_t, cos_t = sin_cos y

		x = (RAD + cos_p) * cos_t
		y = (RAD + cos_p) * sin_t
		z = sin_p

		[x,y,z].map{|t| t*SCALE}
	end
end

class Euler
	include Math

	attr_reader :pts, :qts
	def initialize num
		@del_t = 0.007
		@pts = points num
		euler
	end

	def cent_rand
		rand - 1 * rand
	end

	def update_points(pts)
		@pts = pts
	end

	def points num
		(1..num).map { [cent_rand, cent_rand]}
	end

	def diff(x,y)
		# nonlinear oscillator
		# b = 1 ; [	y, -b*y - Math.sin(x), z]

		# b= 3 ; k=Math.cos(x*y) # x, y, z all good!
		# [y, -x*k -b*y + PI*Math.sin(y), 1]

		# pendulum
		# b = 0 ; [y, -Math.sin(x),1]

		# huygens clocks 
		# b = 2 ; k = 1 # x, y, z all good!
		# [y, -x*k -b*y + 6*Math.cos(z), 1]

		# split up
		# b = 1 ; k = 1.2*cos(x) # x, y, z all good!
		# [y, - x*k - b*y + PI*sin(y)]
		[1,1]

		# [-y, x]
	end

	def euler
		@qts = @pts.map do |x, y|
			s, t = diff x, y
			dx = x + s * @del_t
			dy = y + t * @del_t

			s, t = diff dx, dy
			ddx = dx + s * @del_t
			ddy = dy + t * @del_t

			[(dx + ddx) /2.0, (dy + ddy) /2.0]
		end
	end
end
