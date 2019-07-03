  URL_STUB = '/Users/Jon/Desktop/crude/RubyProcessing/my_vacation/'

  class FireFly
    def initialize(ww, hh)
      @pert = 3*rand/5 + 3/5.0
      @w = ww * rand
      @h = hh * rand/2.0
    end

    # todo:
    # rising fireflies
    # house, car, tree
    # blinky grass?

    def render_body
      # vibrancy of body light
      rand < 0.99 ? fill(0,0,0,60) : fill(68, 100*@pert, 100*@pert)
        # write code to raise lights
      ellipse(@w, @h, 10, 10) # body
    end
  end

  class Yard
    def initialize

    end

    def render_yard
      # fence
      stroke(30,0,60,30); stroke_width(0.1)
      (0..8).each do |i|
        line(300, (50+2*i)*height/100, width, (43+2*i)*height/100)
      end ; no_stroke

      # grass
      fill(100,255,30);
      quad(0, 65*height/100,
           width, 58*height/100,
           width, height,
           0, height)

      # sidewalk
      fill(30,20,55);
      quad(0, 80*height/100,
           width, 73*height/100,
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
    @yard.render_yard
    @firefly.each{|fly| fly.render_body}
    fill(220,20,100) ; text('Fireflies on Cook Avenue', 20, 9*height/10)
  end