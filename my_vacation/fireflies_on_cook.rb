  URL_STUB = '/Users/Jon/Desktop/crude/RubyProcessing/my_vacation/'

  class FireFly
    def initialize(width, height)
      @w, @h = width, height
      @pert = 3*rand/5 + 3/5.0
      render_body
    end

    def render_body
      no_stroke
      # vibrancy of body light
      if rand < 0.99
        fill(0,0,0,60)
      else
        fill(68, 100*@pert, 100*@pert)
        # write code to raise lights
      end

      ellipse(@w-60, @h-30, 10, 10) # body
    end
  end

  class Yard
    def initialize

    end

    def render_yard
      stroke_width 40
      # sidewalk
      stroke(30,20,30); line(0, 80*height/100, width, 73*height/100)
      fill(30,20,30); rect(0, 80*height/100, width, 300)

      stroke_width 0.2
      # grass
      stroke(100,255,30); line(0, 65*height/100, width, 58*height/100)      
      fill(100,255,30); rect(0, 65*height/100, width, 30)

      # fence
      stroke(30,0,60); line(300, 50*height/100, width, 43*height/100)

    end
  end


  def settings ; size(1400, 500) end
  
  def setup
    frame_rate 5 ;
    background 0
    colorMode(HSB,360,100,100,100)
    text_font create_font("times", 30)
    @firefly = [*1..50].map{ |i| FireFly.new(rand*width, rand*height) }
    @yard = Yard.new
    fill(0,0,100) ; text('My Lakewood Vacation', 10, height/10)
    # @img = loadImage(URL_STUB+'beach.jpg')
  end

  def draw
    # image(@img, 0, 0)
    @firefly.each{|fly| fly.render_body}
    fill(220,20,100) ; text('My Lakewood Vacation', 10, height/10)
    @yard.render_yard
  end