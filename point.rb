class PointAtInfinity
  
  def +(other)
    return other
  end

  def *(other)
    return other
  end

  def is_infinity?
    return true
  end
  
  def to_s
    "Infinity"
  end

end



class Point
  attr_reader :x, :y

  def initialize(e, x,y)
    @e = e
    @x = x
    @y = y
  end

  def is_infinity?
    return false
  end

  
  def to_s
    "(#{@x}, #{@y})"
  end

  def *(n)
    return 0    if n == 0
    return self if n == 1
    if n % 2 == 1
      return (self) + (self*(n-1))
    else
      return (self+self) * (n / 2)
    end    
  end
  

  # http://www.math.brown.edu/~jhs/Presentations/WyomingEllipticCurve.pdf
  def +(q)    
    if q.is_infinity?
      return self
    end
    
    p = self
    # SELF  = P
    # OTHER = Q
      
    #puts "p = #{p.x}, #{p.y}"
    #puts "q = #{q.x}, #{q.y}"
    
    if (q.x == p.x) and (q.y != p.y)
      return PointAtInfinity.new
    end
    
    # Double the point, its the same...
    if (q.x == p.x and q.y == p.y) 
      return PointAtInfinity.new if p.y == 0      
      s = (3* p.x**2 + @e.a) * MathHelpers.mult_inv(2*p.y, @e.p)
    # Add the point together..
    else
      s = (p.y - q.y) * MathHelpers.mult_inv(p.x - q.x, @e.p)      
    end  

    xr = (s**2 - p.x - q.x) 
    yr = (s*(p.x - xr) - p.y)
    return Point.new(@e, xr % @e.p, yr  % @e.p)
  end    
end