require (File.expand_path('./lorenz', File.dirname(__FILE__)))
	# binding = $app

	def settings
		size(displayWidth/2, displayHeight/2)
	end

	def setup
		colorMode(HSB,360,100,100,60)
		@w, @h = width/2.0, height/2.0
    frame_rate 400
		background 0
		no_stroke

		@trajectories = get_trajectories(3)
	end

	def get_trajectories num
		(0...num).map{ Lorenz.new }
	end

	def plot_lorenz(attractor)
		x = attractor.x * 5 + @w
		y = attractor.y * 5 + @h
		c = attractor.color
		fill(*c) ; ellipse(x,y,6,6)
		attractor.blink
	end

	def draw
		clear
		@trajectories.each{|t| plot_lorenz t}
	end