require 'byebug'

class Combinatorics
  def evalPair(fsym, x, y)
    self.send(fsym, x, y)
  end

  def monics(d, c)
    fact(c) / fact(c-d)
  end

  def weirdOperator(c) # An Always zero function.
    (0..c).inject(0) {|a, k| a + (-1)**k * 1.0/( fact(c-k) * fact(k) )}
    # (0..c).inject(0) {|a, k| a + (-1)**k * choose(c,k) }
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

it = Combinatorics.new
that = it.weirdOperator(4)
puts that

byebug
3
