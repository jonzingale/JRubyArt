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
      # sidewalk
      stroke(30,20,60); line(0, 8*height/10, width, 7*height/10)
      # grass
      stroke(100,255,60); line(0, 7*height/10, width, 6*height/10)      
      # fence
      stroke(30,0,60); line(0, 6*height/10, width, 5*height/10)

    end
  end


  def settings ; size(500, 500) end
  
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
    @yard.render_yard
    @firefly.each{|fly| fly.render_body}
    fill(220,20,100) ; text('My Lakewood Vacation', 10, height/10)
  end