require 'digest'
require 'pp'
require './math_helpers.rb'
require './point.rb'
require './curve.rb'


class ECDSA

  def generate_signature(message)
    e = Digest::SHA256.hexdigest(message)
    da = generate_private_key
    qa = @g * da
    pp qa
    pp e
    r = 0
    while r == 0
      k = generate_private_key
      point = @g * k
      r = point.x % @n
    end
    pp r
  end
  

  # Secp256k1 Params
  def initialize
    @p = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F
    @a = 0
    @b = 7
    @e = Curve.new(@a,@b,@p)
    @g = @e.point(0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798, 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8)
    @n = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141    
  end

  # THIS IS NOT SECURE!
  def generate_private_key
    prng = Random.new
    prng.rand(@n)
  end
  

end




ecdsa = ECDSA.new
ecdsa.generate_signature("We Launch at midnight")
