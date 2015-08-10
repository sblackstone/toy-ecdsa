require 'pp'
require 'digest'
require './math_helpers.rb'
require './point.rb'
require './curve.rb'


class ECDSA

  def verify_signature(message, r,s, qa)
    e = Digest::SHA256.hexdigest(message)
    z = e.to_i(16) % @n
    w = MathHelpers.mult_inv(s, @n)
    u1 = (z*w) % @n
    u2 = (r*w) % @n
    p = (@g*u1) + (qa*u2)    
    return (p.x % @n) == (r % @n)    
  end
  

  def generate_signature(private_key, message)
    e = Digest::SHA256.hexdigest(message)
    z = e.to_i(16) % @n
    k = 0
    s = 0
    while s == 0
      r = 0
      s = 0 
      while r == 0
        k = generate_random_k
        point = @g * k
        r = point.x % @n
      end
      k_inv = MathHelpers.mult_inv(k,@n)
      s = (k_inv * (z + r*private_key)) % @n
    end
    return {:r => r, :s => s, :public_key => @g * private_key }
  end
  

  def initialize
    # Secp256k1 Params
    @p = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F
    @a = 0
    @b = 7
    @e = Curve.new(@a,@b,@p)
    @g = @e.point(0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798, 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8)
    @n = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141    
  end

  # THIS IS NOT SECURE!
  def generate_random_k
    prng = Random.new
    prng.rand(@n-1)
  end
  
end
