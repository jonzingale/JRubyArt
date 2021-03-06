include Math

# Extend Functionality to print `Long` images to a file.

FILES_PATH = File.expand_path('./../', __FILE__).freeze
EDGES_REGEX = /\((\d+),(\d+)\)/
Tau = 3.1415927 * 2
SCALE = 120

def get_lists # Haskell to pass files to ruby.
  @lists, file = [], "#{FILES_PATH}/lists.txt"
  File.open(file, 'r').each { |line| @lists << line }
end

def setup
  size displayWidth, displayHeight
  colorMode(HSB,360,100,100,100)
  text_font create_font("SanSerif",30)
  @w, @h = width/2, height/2
  stroke(100,199,100)
  fill(100,199,100)
  frame_rate 20
  background 0

  print_each_graph
end

def print_each_graph
  get_lists

  @lists.each_with_index do |str, i|
    list = list2edges str
    n = list.flatten.max
    vertices n, i
    edges list
  end
end

def vertices n, i
  w, h = width/5, height/3.5
  k, j = i.divmod 5
  # how can i space out the n many in the list on the 'page'?
  @points = rootsUnity(n).map{|s,t| [s*SCALE + w*j + 160 , t*SCALE + h*k + 200]}

  @points.each_with_index do |pts, i|
    ellipse(*pts, 10, 10)
    fill(30,30,100)
    text("#{i+1}",*pts)
  end
end

def edges list
  list.each { |s, t| line *(@points[s-1] + @points[t-1]) }
end

def list2edges str
  str.scan(EDGES_REGEX).map{|uv| uv.map(&:to_i)}
end

def rootsUnity n
  (0...n).map{|i| [sin(Tau*i/n), cos(Tau*i/n)] }
end
