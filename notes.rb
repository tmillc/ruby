=begin
&&, || evaluate the left side first
true || anything will stop after evaluating the left side
false && anything will stop after evaluating the left side
=end

true || "hello"  # true

var = "hi"
var2 = "hi".upcase

varInline = "hi".upcase!   # equivalent to var2

=begin  .include?
 evaluates to true if it finds what it's looking for and false otherwise.
=end

"hi".include? "r" # false

if "hi there".include? "h"
  puts "there's an h"
end

puts "there's an h" if "hi there".include? "h" 		# equivalent to above

#  Uh oh! What's happening here? These don't seem equivalent according to codecademy's script.rb
=begin   Commented out to avoid user input pause

print "Enter a string: "
user_input = gets.chomp
user_input.downcase!
puts "there's an s" if user_input.include? "s"

print "Enter a string: "
user_input2 = (gets.chomp).downcase!                # this one gives: undefined method `include?' for nil:NilClass
puts "there's an s" if user_input.include? "s"
# apparently using an inline modifier like .downcase! is causing user_input2 to return nil

# another fix:
print "Enter a string: "
user_input3 = (gets.chomp).downcase 				# changed .downcase! to .downcase
puts "there's an s" if user_input.include? "s"
=end

=begin  .gsub
  global substitution
=end

puts "great".gsub(/t/, "tly")

=begin   Ranges
=end

# outputs 1 2 3 4 5 6 7 8 9
for num in 1...10
  puts num
end

# outputs 1 2 3 4 5 6 7 8 9 10
for num in 1..10  # note .. vs ...
  puts num
end

=begin   Loops, Iterators
  {} are generally interchangeable with the keywords do (to open the block) and end (to close it). 
  loop { print "Hello, world!" } creates an infinite loop
=end

i = 0
loop do			  # will print 123456
  i += 1
  print "#{i}"    # prints 1 on first iteration
  break if i > 5 
end
puts

i = 0
loop do			  # will print 12345   ----- !!!!!! DOESN'T THOUGH    <- oh boy, ">,>= error, nothing to see here"
  break if i > 5  # now we are breaking before incrementing           <- but we're still checking strictly <, not <=
  i += 1
  print "#{i}"    # prints 1 on first iteration
end
puts

=begin   Next -- wait, whoa
The 'next' keyword can be used to skip over certain steps in the loop. 
For instance, if we don't want to print out the even numbers, we can write:

for i in 1..5
  next if i % 2 == 0
  print i
end

=end

# outputs 111315
for i in 10..15
  next if i % 2 == 0
  print i
end

puts

# equivalent to above
for i in 10..15
  if i % 2 == 1    # notice
    print i
  end
end

=begin   Other Stuff
=end

=begin testing Next will come back to this
for i in (2%0)..((2%5)+1)   # for i in (from 0 to  2, inclusive)
							# also an expment for expression-ranges
							# experience/experiment
  puts "#{i}"
end
=end

