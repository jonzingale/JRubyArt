# require 'byebug'

class Epic
  def evalPair(fsym, x, y)
    self.send(fsym, x, y)
  end

  def monics(d, c)
    fact(c) / fact(c-d)
  end

  # def monster(d, c) # monics is symmetric so zero for all time!
  #   # (0..c).inject(0) {|a, k| a + (-1)**k * choose(c, k) * monics(d, c) }
  #   (0..c).map {|k| (-1)**k * choose(c, k) * monics(d, c) }
  # end

  def fact(n)
    (1..n).inject(1, :*)
  end

  def choose(n, k)
    fact(n) / (fact(k) * fact(n-k))
  end

  def epis(d, c)
    (0..c).inject(0) {|a, k| a + (-1)**k * choose(c,k) * (c-k)**d }
  end
end

# it = Epic.new
# that = it.monics(3, 3)
# puts that

# byebug
# 3
