require (File.expand_path('./color_crawlers', File.dirname(__FILE__)))

	module ColorConversion
		def rgb_converter(m=0,n=0)
			k = get(m,n)
			r = 256 + k/(256**2)
			g = k/256 % 256
			b = k % 256
			[r,g,b]
		end
	end

	class BeingInTheWorld
		include ColorConversion

		def suggest(crawler)
			@m = @m.nil? ? crawler.desire : rgb_converter(mouseX,mouseY)
			crawler.desired(@m)
		end

		def perceive(crawler,look)
			theres = crawler.send(look)
			those = theres.map{|root,there| [root,rgb_converter(*there)]}
			crawler.see(those)
		end

		def impose(crawler) # modify the space.

		end
	end

	include ColorConversion
	attr_reader :thing, :crawler_z, :crawler_y, :crawler_p

	def settings
		size(displayWidth, displayHeight)
	end

	def setup
		background(20) ; frame_rate 30
		text_font create_font("SanSerif",55) ; no_stroke

		@img = loadImage(ENV['HOME']+"/Desktop/crawlerImages/pic1.png") # right
		# @img = loadImage(ENV['HOME']+"/Desktop/crawlerImages/cornucopia.png") # right
		@jmg = loadImage(ENV['HOME']+"/Desktop/crawlerImages/pic2.png") # left
		@w,@h = [width,height].map{|i|i/2.0}
		@i = 0

		@crawler_z = ColorCrawlers.new('z',@w,@h)
		@crawler_y = ColorCrawlers.new('y',@w,@h)
		@crawler_p = ColorCrawlers.new('p',@w,@h)
		@thing = BeingInTheWorld.new
	end

	def scale_img(image,scale_denom,x,y)
		scale(@width/scale_denom.to_f)
		image(image,x,y)
		scale(scale_denom/@width.to_f)
	end

	def images
		if @i < 1
			scale_img(@img, 2*@img.width.to_f, @width/2, 20)# right picture
			scale_img(@jmg, 3*@img.width.to_f, 0, 0)# left picture

			save(ENV['HOME']+'/Desktop/crawlerImages/test.png')
			@loaded = loadImage(ENV['HOME']+"/Desktop/crawlerImages/test.png") ; @i = 1
		else
			image(@loaded,0,0) ; @loaded = get
		end
	end

	def be_in_world(crawler,look,motive)
		thing.suggest(crawler)

		thing.perceive(crawler,look)
		crawler.send(motive)

		pos = crawler.position
		name = crawler.name
		fill 0 ; text(name,*pos)
	end

	def ellipses
		c, *oords = [(width+@w)/1.9, (height+@h)/1.8, 200, 200]

		# color ellipse
		@m = @m.nil? ? [255,40,50] : rgb_converter(mouseX,mouseY)
		fill(*@m,250) ; ellipse(c-100,*oords)

		# best guess ellipse
		pos = crawler_y.position
		color = rgb_converter(*pos)
		fill(*color,200) ; ellipse(c,*oords)
	end

	def draw
		images
		be_in_world(crawler_z, :look_roots, :motive_z)
		be_in_world(crawler_y, :look_roots, :motive_y)
		be_in_world(crawler_p, :look_roots, :motive_p)
		ellipses

		# no idea.
		# fill(0) ; text("distance from desire: #{@m} units",100,40)

		# # show best guess distance
		fill(0) ; text("distance from desire: #{crawler_y.guess.round} units",100,40)
	end
