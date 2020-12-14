require 'matrix'
require 'cmath'

  def settings
    scale = 1.3
    size(displayWidth/scale, displayHeight/scale)
  end

  def setup
    colorMode(HSB,360,100,100,100)
    @w, @h = [width/2, height/2]
    stroke_width 1
    frame_rate 12
    background 0

    @pts = points 6000
    @del_t = 0.03
  end

  def cent_rand
    10 * (rand - 1 * rand)
  end

  def points num
    (1..num).map { [cent_rand, 1*cent_rand, cent_rand] }
  end

  def diff(x,y,z)
    [-y, Math.sin(x), 1]
  end

  def improved_euler
    @next_pts = @pts.map do |x,y,z|
      s, t, r = diff x, y, z
      dx = x + s * @del_t
      dy = y + t * @del_t
      dz = z + r * @del_t

      s, t, r = diff dx, dy, dz
      ddx = dx + s * @del_t
      ddy = dy + t * @del_t
      ddz = dz + r * @del_t

      [(dx + ddx) /2.0, (dy + ddy) /2.0,  (dz + ddz) /2.0]
    end
  end

  Xu, Yu = 20, 20

  def draw
    clear
    improved_euler
    @pts.zip(@next_pts).each do | (x,y,z), (s,t,r) |
      stroke 180+r, 100, 100, 80

      # line (Xu*x)+@w, (Yu*z)+@h, (Xu*s)+@w, (Yu*r)+@h
      line (Xu*x)+@w, (Yu*y)+@h, (Xu*s)+@w, (Yu*t)+@h
    end

    @pts = @next_pts
  end