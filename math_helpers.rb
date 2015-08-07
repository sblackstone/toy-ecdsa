module MathHelpers
  def MathHelpers.extended_gcd(a,b)
    if a % b == 0
        return 0, 1
    else
        x, y = extended_gcd(b, a % b)
        return y, (x - y * (a / b))
    end
  end
  
  
  def MathHelpers.mult_inv(n,p)
    if n < 0
      n = p + n
    end        
    ans = extended_gcd(p,n)
    a = ans[1] % p
    
    if a*n % p != 1
      throw "Bad inverse #{a} is not -1 of #{n} mod #{p}"
    end        
    return a
  end
end
