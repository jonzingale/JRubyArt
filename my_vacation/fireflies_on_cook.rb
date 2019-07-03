  URL_STUB = '/Users/Jon/Desktop/crude/RubyProcessing/my_vacation/'
  PI = 3.1415926

  class SandPiper
    def initialize(width, height)
      @w, @h = width, height
      @r_ary = (0..2).map{|t| t/2.0}
      render_body
    end

    def trigs(theta)
      %w(cos sin).map{|s| Math.send(s, theta)}
    end

    def rotate(ary)
      ary.unshift(ary.pop)
    end

    def render_body
      r_sel = rotate(@r_ary).first
      rando = PI/2 - PI * r_sel / 7 # 1.5, 3
      cos, sin = trigs(rando).map{|t| t*120}

      stroke_width(6) ; stroke(120)
      line(@w,@h+50,@w+cos,@h+sin) # left leg

      no_stroke ; fill(360)
      ellipse(@w, @h, 130, 100) # body
      ellipse(@w-60, @h-30, 60, 60) # head
      bezier(@w-40, @h-30, @w+130, @h-10, @w+130, @h-30, @w+50, @h+10) # tail
      fill(0) ; ellipse(@w-70, @h-35, 10, 10) # eye
      fill(60) ; ellipse(@w+10, @h-10, 80, 60) # wing

      bezier(@w-89, @h-33, @w-169, @h, @w-159, @h, @w-89, @h-23) # beak

      stroke_width(6) ; stroke(120)
      line(@w+10,@h+45,@w+20-cos,@h+sin) # right leg
    end
  end

  class FireFly
    def initialize(width, height)
      @w, @h = width, height
      @r_ary = (0..2).map{|t| t/2.0}
      render_body
    end

    def trigs(theta)
      %w(cos sin).map{|s| Math.send(s, theta)}
    end

    def rotate(ary)
      ary.unshift(ary.pop)
    end

    def render_body
      r_sel = rotate(@r_ary).first
      rando = PI/2 - PI * r_sel / 7 # 1.5, 3

      no_stroke ; fill(360)
      rand < 0.9 ? fill(0,0,0) :
        rand < 0.99 ? fill(68, 100, 100) : fill(68,100,63)

      ellipse(@w-60, @h-30, 20, 20) # head
    end
  end

  def settings ; size(500, 500) end
  
  def setup
    frame_rate 1 ; 
    colorMode(HSB,360,100,100,100)
    text_font create_font("SanSerif", 30)
    # @piper = SandPiper.new(width/3, height/2+160)
    @firefly = [*1..20].map{ |i| FireFly.new(rand*width, rand*height) }
    # @img = loadImage(URL_STUB+'beach.jpg')
  end

  def draw
    clear
    # image(@img, 0, 0)
    @firefly.each{|fly| fly.render_body}
    # @piper.render_body
    fill(0,0,100) ; text('My Lakewood Vacation',60,160)
  end