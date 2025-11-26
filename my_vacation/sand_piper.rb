require 'jruby_art'

PI = Math::PI

class SandPiper
  def initialize(width, height, app)
    @w, @h = width, height
    @app = app
    @r_ary = (0..2).map { |t| t / 2.0 }
    render_body
  end

  def trigs(theta)
    %w(cos sin).map { |s| Math.send(s, theta) }
  end

  def rotate(ary)
    ary.unshift(ary.pop)
  end

  def render_body
    r_sel = rotate(@r_ary).first
    rando = PI / 2 - PI * r_sel / 7
    cos, sin = trigs(rando).map { |t| t * 120 }

    @app.stroke_weight 6
    @app.stroke 120
    @app.line @w, @h + 50, @w + cos, @h + sin # left leg

    @app.no_stroke
    @app.fill 360
    @app.ellipse @w, @h, 130, 100 # body
    @app.ellipse @w - 60, @h - 30, 60, 60 # head
    @app.bezier @w - 40, @h - 30, @w + 130, @h - 10, @w + 130, @h - 30, @w + 50, @h + 10 # tail
    @app.fill 0
    @app.ellipse @w - 70, @h - 35, 10, 10 # eye
    @app.fill 60
    @app.ellipse @w + 10, @h - 10, 80, 60 # wing

    @app.bezier @w - 89, @h - 33, @w - 169, @h, @w - 159, @h, @w - 89, @h - 23 # beak

    @app.stroke_weight 6
    @app.stroke 120
    @app.line @w + 10, @h + 45, @w + 20 - cos, @h + sin # right leg
  end
end

class MyVacation < Processing::App
  def settings
    size 1280, 720
  end

  def setup
    frame_rate 20
    color_mode HSB, 360, 100, 100, 100
    text_font create_font('SansSerif', 100)
    @piper = SandPiper.new(width / 3, height / 2 + 160, self)
    # Assuming code is ran from JRubyArt
    @img = load_image('my_vacation/beach.jpg')
  end

  def draw
    image @img, 0, 0
    fill 80
    text 'My Beach Vacation', 60, 170
    @piper.render_body
  end
end

MyVacation.new
