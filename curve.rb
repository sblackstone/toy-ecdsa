class Curve
  attr_reader :a, :b, :p
  
  def initialize(a,b, p)
    @a = a
    @b = b
    @p = p
  end
  
  def point(x,y)
    return Point.new(self, x,y)
  end  

end

