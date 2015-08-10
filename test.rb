require './ecdsa.rb'

ecdsa = ECDSA.new

message = "We Launch At Midnight"

sig = ecdsa.generate_signature(0x08f96d2fa8a7d46598acb969aa09ed54caf079235ed0203763640cc1b8917055, message)

puts sig[:public_key].x.to_s(16) 
puts sig[:public_key].y.to_s(16) 

pp ecdsa.verify_signature(message, sig[:r], sig[:s], sig[:public_key])

