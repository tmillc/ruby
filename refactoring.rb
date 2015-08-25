$VERBOSE = nil  # Explained later
require 'prime' 

def first_n_primes_try1(n)
  # Check for correct input
  unless n.is_a? Integer
    return "n must be an integer."
  end

  if n <= 0
    return "n must be greater than 0."
  end
  
  # set to an empty array if it doesn't exist
  prime_array = [] if prime_array.nil?
  
  prime = Prime.new
  for num in (1..n)
    prime_array.push(prime.next)
  end
  return prime_array
end

first_n_primes_try1(10)

########
# try2: Refactored
########

$VERBOSE = nil   
require 'prime'  

def first_n_primes_try2(n)
  # Check for correct input
  return "n must be an integer." unless n.is_a? Integer
  return "n must be greater than 0." if n <= 0
  
  prime_array ||= []
  
  prime = Prime.new
  n.times { prime_array << prime.next }
  prime_array  # implicit return
end

first_n_primes_try2(10)

#########
# $VERBOSE = nil allows us to use old-style (1.8) Prime.new
# but Ruby 1.9 Prime class makes the array automatically
########

require 'prime'

def first_n_primes_try3(n)
  # Check for correct input
  "n must be an integer" unless n.is_a? Integer
  "n must be greater than 0" if n <= 0

  # The Ruby 1.9 Prime class makes the array automatically!
  prime = Prime.instance
  prime.first n
end

first_n_primes_try3(10)
