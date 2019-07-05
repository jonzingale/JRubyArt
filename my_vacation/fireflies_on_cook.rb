  URL_STUB = '/Users/Jon/Desktop/crude/RubyProcessing/my_vacation/'

  class FireFly
    def initialize(ww, hh)
      @pert = 3*rand/5 + 3/5.0
      @w = ww * rand
      @h = hh * rand/2.0
    end

    def render_body
      # vibrancy of body light
      rand < 0.99 ? fill(0,0,0,0) : fill(68, 100*@pert, 100*@pert)
        # write code to raise lights
      ellipse(@w, @h, 10, 10) # body
    end
  end

    # todo:
    # rising fireflies
    # house, car, tree
    # blinky grass?

  class Yard
    def initialize

    end

    def render_tree(k, thick=0.7)
      fill(36, 92, 20,80)
      quad(k*width/10, 8*height/10,
           k*width/10, 0,
           (k+thick)*width/10, 0,
           (k+thick)*width/10, 8*height/10)

      fill(120, 50, 70)
      (0..8).each { |i| ellipse(300+50*i,50,20*i,30*i) }
      (0..8).each { |i| ellipse(100+50*(8-i),50,20*(8-i),30*(6-i)) }
      (0..8).each { |i| ellipse(800+50*(8-i),50,20*i,30*i) }

      no_stroke
    end

    def render_yard
      # trees
      render_tree(8)
      render_tree(3, 0.4)

      # grass
      fill(100,255,30);
      quad(
        0, 48*height/100, width, 55*height/100,
        width, height, 0, height
      )

      # fence
      stroke(30,0,60,100); stroke_width(0.6)
      (0..8).each do |i|
        line(300, (43+2*i)*height/100, width, (50+2*i)*height/100)
      end ; no_stroke

      # sidewalk
      fill(30,30,35);
      quad(0, 73*height/100,
           width, 80*height/100,
           width, height,
           0, height)

    end
  end


  def settings ; size(1400, 500) end
  
  def setup
    frame_rate 5 ;
    background 0
    colorMode(HSB,360,100,100,100)
    text_font create_font("word", 25)
    @firefly = (1..80).map{ |i| FireFly.new(width, height) }
    @yard = Yard.new
  end

  def draw
    fill(0,0,0,70)
    rect(0,0,width,height)
    @yard.render_yard
    @firefly.each{|fly| fly.render_body}
    fill(220,20,100) ; text('Fireflies on Cook Avenue', 20, 9*height/10)
  end