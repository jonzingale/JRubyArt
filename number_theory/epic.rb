# require 'byebug'

class Epic
  def evalPair(fsym, x, y)
    self.send(fsym, x, y)
  end

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
# that = it.evalPair(:epis, 4, 3)
# puts that

# byebug
# 3
