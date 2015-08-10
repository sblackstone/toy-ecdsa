require './ecdsa.rb'



message = "We Launch At Midnight"
ecdsa = ECDSA.new

sig = ecdsa.generate_signature(12345, message)

print "Signature = "
pp sig


pp ecdsa.verify_signature(message, sig[:r], sig[:s], sig[:public_key])

