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

# also tr
"abc123".tr('bc', '56') 		# => "a56123"
"abc123".tr('bc', '561111111')  # => "a56123" 
"how are you".tr('^aeiou', 'X') # => "XoXXaXeXXou" 

'abcde'.tr('bda', '123')      # => "31c2e"
'abcde'.gsub(/bda/, '123')    # => "abcde"
'abcde'.gsub(/b.d/, '123')    # => "a123e"
'abcde'.gsub(/b.d/, '123456') # => "a123456e"
=begin   Ranges
=end

# outputs 1 2 3 4 5 6 7 8 9
for num in 1...10  # excludes 10
  puts num
end

# outputs 1 2 3 4 5 6 7 8 9 10
for num in 1..10  # includes 10
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
  next if i % 2 == 0 # skip if even
  print i
end

puts

# equivalent to above
for i in 10..15
  if i % 2 == 1    # do if odd
    print i
  end
end

=begin   

=end

=begin   Other Stuff
=end

ObjectSpace._id2ref(20)  # true
ObjectSpace._id2ref(0)   # false
ObjectSpace._id2ref(1)   # 0
ObjectSpace._id2ref(3)	 # 1
ObjectSpace._id2ref(5)   # 2

Array.new << "hi" << 5 << 6           # ["hi", 5, 6]
(Array.new << "hi" << 5 << 6).first   # "hi"
# Note:  can use negative indices with arrays to go backwards
# Note: Arrays can be sliced
array = [1,2,3,4,5,6,7,8]
array[2,1]		# [3]
array[2,3]		# [3,4,5]
array[6,500] 	# [7,8]
array[-3,2] 	# [6,7]

[1,2,3,4,5] == (1..5).to_a   # true
[1,2,3,4] == (1...5).to_a	 # true
array.pop 	# => 8, and now array = [1,2,3,4,5,6,7]

[1,2,3,4,5].inject(:+)   # => sums, 15
(1..5).to_a.inject(:*)   # => factorial

## Code blocks
1.times do
  puts "I'm a code block!"
end
1.times { puts "As am I!" }
##

=begin testing Next will come back to this
for i in (2%0)..((2%5)+1)   # for i in (from 0 to  2, inclusive)
							# also an expment for expression-ranges
							# experience/experiment
  puts "#{i}"
end
=end

=begin   .split
Takes in a string and returns an array, dividing the text by a given delimiter
=end

words = "hi,how,are,you".split(",")

words.each do |word|
    print word			# prints each word in the words array
end

words.each do |word| 
	if word == "hi"
		print "NO" + " " + "WAY"
	else
		print word
	end
end

=begin   hashes
  key-value pairs
=end

tree1 = { 	"type" => "apple",
			"req pollinator" => "yes" }
puts tree1["type"]

pets = Hash.new  			# Can also initialize an empty hash
pets2 = Hash.new("bunny") 	# Can give a default initial value to every key
# Hmm, by putting keys of integer 0,1,... we can get array functionality from a hash
pets[:dog] = ["ralph", "george", "bark"]
pets[:cat] = ["fluffy", "k", "rkjfg"]
pets[0] = true
pets[1] = false
pets[2] = true
#  pets["dog"][1] will return "george" as we are seeking the 1th element from the array pets["dog"]

puts "\n"
puts "puts'ing pets.each as one x"
pets.each { |x| puts "#{x}" }
puts "\n"
puts "puts'ing pets.each as x, y"
pets.each { |x, y| puts "#{x}, #{y}" }
puts "\n"
puts "puts'ing only the names of pets"
pets.each { |x, y| puts "names: #{y}" }  # 2 dummy vars but only using the second
puts "puts'ing pets.each as x, y, and z   (but there's no z)"
pets.each { |x, y, z| puts "#{x}, #{y}, and #{z}" }

pets[:turtle] 		  # => nil
# pets.fetch(:turtle) # ERROR

=begin   Methods
=end
def hi_there
  puts "hello"
end

# splat arguments, could be more than one argument
def shout_out(message, *friends)
  friends.each { |f| puts "#{f}: #{message}" }
end
shout_out("Hi there!", "Bob", "Steve", "Dave")

# splat doesn't have to come at the end
def shout_out(message, *friends, signoff)
  friends.each { |f| puts "#{f}: #{message}" }
  puts signoff
end
shout_out("Hi there!", "Bob", "Steve", "Dave", "Pete", "I'll see you later")

# splat can be used to flatten arrays
nums = [1,2,3]
upto5oops = [nums, 4,5]  # => [[1,2,3],4,5] 
upto5 = [*nums, 4,5]     # => [1,2,3,4,5]
nums.unshift(:first) 	 # => [:first, 1,2,3]
nums.shift				 # => [1,2,3]

# parallel assignment with just one variable! Keep watchful!
first_name, = ["Thomas", "Tomson"]

def by_five?(n)
  return n % 5 == 0
end

def capitalize(string) 
  puts "#{string[0].upcase}#{string[1..-1]}" # puts cap-first, then second through last elems
end




################ SORTING
book_1 = "A Cool Cat"
book_2 = "A Great Day"
book_3 = "A Cool Cat"
book_1 <=> book_2   # returns -1
book_2 <=> book_1   # returns 1
book_1 <=> book_3   # returns 0

books = ["Charlie and the Chocolate Factory", "War and Peace", "Utopia", "A Brief History of Time", "A Wrinkle in Time"]
books.sort! { |firstBook, secondBook| firstBook <=> secondBook } # sorts in place, in ascending order
books.sort! { |firstBook, secondBook| secondBook <=> firstBook } # sorts in place, in descending order


def alphabetize(arr, rev=false)
  if rev
    arr.sort { |item1, item2| item2 <=> item1 }
  else
    arr.sort { |item1, item2| item1 <=> item2 }
  end
end

books = ["Heart of Darkness", "Code Complete", "The Lorax", "The Prophet", "Absalom, Absalom!"]

puts "A-Z: #{alphabetize(books)}"  			# rev is false, so arr.sort { |i1, i2| i1 <=> i2 }
puts "Z-A: #{alphabetize(books, true)}"		# rev is true,  so arr.sort { |i1, i2| i2 <=> i1 }

=begin Since it is the last line of the method, the sorted array will be returned.
this should go in the functions section
=end
def alphabetize(arr, rev=false)
    arr.sort!
    if rev == true
      arr.reverse!
    end
    return arr   # note the function fails as called below if this line is absent: our if is returning nil, so our function returns nil
end

numbers = [3,4,2,3]
puts alphabetize(numbers)

# interesting, this block will sort odd numbers before even numbers
[1,2,3,4,5,6].sort do |x,y|
  if x.odd? and y.odd?
    0
  elsif x.odd?
    -1
  else
     1
  end
end

arr.sort! { rand(-1..1) }      # shuffle the array


=begin Hashes

=end
new_hash = { "one" => 1 }	# Hash literal notation
new_hash = Hash.new 		# Hash constructor notation

new_hash["two"] 		# accessing a key that doesn't exist returns nil
menagerie = { :foxes => 2, :giraffe => 1, :canaries => 4 }  # using symbols as keys

"string".object_id == "string".object_id  # => false, actually different objects
:symbol.object_id == :symbol.object_id    # => true,  the same object

strings = ["HTML", "CSS", "JavaScript", "Python", "Ruby"]
symbols = []
strings.each { |s| symbols.push(s.to_sym) }  # now symbols == [:HTML, :CSS, :JavaScript, ... ]

# Note .intern works the same as .to_sym

# Hash "rocket" style
movies = {
    :Go => "a movie",
    :Help => "another movie"
}

# new syntax as of 1.9, 
movies = {
    Go: "a movie",
    Help: "another movie"
}

# filter a hash for values that meet certain criteria
movie_ratings = {
  memento: 3,
  primer: 3.5,
  the_matrix: 5,
  truman_show: 4,
  red_dawn: 1.5,
  skyfall: 4,
  alex_cross: 2,
  uhf: 1,
  lion_king: 3.5
}

good_movies = movie_ratings.select { |movie, rating| rating > 3 }  # returns hash that selects from movie_ratings when rating > 3

# can iterate only just keys or just values
my_hash = { one: 1, two: 2, three: 3 }

my_hash.each_key { |k| print k, " " } 	# ==> one two three
my_hash.each_value { |v| print v, " " } # ==> 1 2 3

### Ternary Conditional Expression
# syntax: boolean ? Do this if true: Do this if false
puts 3 < 4 ? "3 is less than 4!" : "3 is not less than 4."

# can shorten some control structures
puts "three is less than four" if 3<4

greeting = gets.chomp
case greeting
 when "English" then puts "Hello!"
 when "French" then puts "Bonjour!"
 else puts "I don't know that language!"
end

#### Conditional Assignment
favorite_book = nil
favorite_book ||= "Cat's Cradle"  		# it was nil before so now it's Cat's Cradle
favorite_book ||= "Invisible Cities" 	# still Cat's Cradle, because it's already assigned
favorite_book = "Invisible Cities" 		# now it's Invisible Cities

### More on Returning
def multiple_of_three(n)
  return n % 3 == 0 ? "True" : "False"
end

# also note, we don't "need" to return anything in a method, it will return the last expression evaluated
# but it's good to always return something explicitly

def a
  return true
end

def b
  return true
end

puts a || b		# evaluates only a, then returns true (true || anything == true)
puts a && b		# must evaluate both a and b. However note (false && anything == false)


[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].each { |x| puts x if x%2==0 }  # puts only even numbers

95.upto(100) { |num| print num, " " } 			# => 95 96 97 98 99 100
"L".upto("P") { |letter| print letter, " " } 	# => L M N O P
# .downto works similarly

3.times { print "hi " } # => "hi hi hi "

3.respond_to?(:next)  		# => true, because we can successfully call 3.next
[1,2,3].respond_to?(:push)  # => true, we can call .push on an array

[1,2,3].push(4)		# => [1,2,3,4]
[1,2,3] << 4		# => [1,2,3,4]
"hi" + " there"		# => "hi there"
"hi" << " there"	# => "hi there"

# String interpolation, "#{variable}" handles different types so no need to call .to_s on ints or arrays etc
["Ruby", 15, [1,2,3]].each do |thing|
  puts "I love #{thing}!" 			#=> I love Ruby! I love 15! I love [1,2,3]!
end


[1,2,3,4].select { |n| n>2 } # => [3,4]
[1,2,3,4].reject { |n| n>2 } # => [1,2]
[1,2,3,4].collect { |n| n*n } # => [1,4,9,16]   Also, .map is an alias for .collect
[1,2,3,4].inject { |acc,n| acc + n } 	# => 10. 'acc' is the accumulator here.
[1,2,3,4].inject(10) { |acc,n| acc + n} # => 20, acc is initialized to 10

#### Getting a method to accept a block
def block_test
  puts "In method"
  puts "Yielding to block..."
  yield
  puts "back in the method!"
end
block_test { puts ">>> We're in the block!" }  # "In method / Yielding to block... / >>> We're in the block! / back in the method!"

# can pass parameters to yield
def yield_name(name)
  yield("Kim")
  yield(name)
end
yield_name("Eric") { |n| puts "My name is #{n}." }  # => "My name is Kim. / My name is Eric."

# Our doubling is actually done inside the block
def double(n)
    yield n
end
double(3) { |n| n*2 }   # => 6

#################
# Procs         #
#################

multiples_of_3 = Proc.new do |n|
  n % 3 == 0
end
(1..100).to_a.select(&multiples_of_3)  # => [3,6,9,...,99]

# A proc that cubes a number
cube = Proc.new { |x| x ** 3 }
# Now we could pass this proc to a method that otherwise accepts a block
[1,2,3].map!(&cube)   # => [1,8,27]   .map and .collect are synonymous

floats = [1.2, 3.45, 0.91, 7.727, 11.42, 482.911]
round_down = Proc.new { |n| n.floor }
ints = floats.collect(&round_down)  	# => [1, 3, 0, 7, 11, 482]

# Who can ride at the amusement park?
group_1 = [4.1, 5.5, 3.2, 3.3, 6.1, 3.9, 4.7]
group_2 = [7.0, 3.8, 6.2, 6.1, 4.4, 4.9, 3.0]
group_3 = [5.5, 5.1, 3.9, 4.3, 4.9, 3.2, 3.2]

over_4_feet = Proc.new { |height| height >= 4 }

can_ride_1 = group_1.select(&over_4_feet)
can_ride_2 = group_2.select(&over_4_feet)
can_ride_3 = group_3.select(&over_4_feet)

# Simple greeter, using a proc
def greeter
    yield		# yields to block
end
phrase = Proc.new { puts "Hello there!" } # our proc
greeter(&phrase)	# calls method with our proc instead of a block

# Even simpler greeting using a proc and the .call method on Procs
hi = Proc.new { puts "Hello!" }
hi.call		# => "Hello!"

# We can pass a method around by its symbol, and we can convert symbols to procs
strings = ["1", "2", "3"]
nums = strings.map(&:to_i)  # ==> [1, 2, 3]

#############
# Lambdas   # 
#############
strings = ["leonardo", "donatello", "raphael", "michaelangelo"]
symbolize = lambda { |parameter| parameter.to_sym }
symbols = strings.collect(&symbolize)
# => [:leonardo, :donatello, :raphael, :michaelangelo]

# Lambdas checks number of arguments (throws error if wrong # args passed)
# Proc ignores unexpected args and assigns nil to missing ones

# When lambdas return, they pass control back to the calling method
# When procs return, it does so immediately without returning to calling method

def batman_ironman_proc
  victor = Proc.new { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end
puts batman_ironman_proc   # => "Batman will win!

def batman_ironman_lambda
  victor = lambda { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end
puts batman_ironman_lambda # => "Iron Man will win!"

# filters an array passing only symbols
symbol_filter = lambda { |item| item.is_a? Symbol }
["raindrops", :kettles, "whiskers", :mittens, :packages].select(&symbol_filter)  
# => [:kettles, :mittens, :packages]


##################
# CLASSES ########
##################

# instance variables begin with @
# class variables begin with @@
# global variables: either define them outside of any method/class, or inside a method/class, begin with $

# inheritance example
class ApplicationError
  def display_error
    puts "Error! Error!"
  end
end

class SuperBadError < ApplicationError  # SuperBadError inherits from ApplicationError
end

err = SuperBadError.new
err.display_error			# instances of SuperBadError have access to the display_error method

# Over-riding inherited methods
class Creature
  def initialize(name)
    @name = name
  end
  
  def fight		# fight method for parent class Creature
    return "Punch to the chops!"
  end
end

class Dragon < Creature
    def fight	# fight method for derived class Dragon
        return "Breathes fire!"
    end
end

# Using a parent class method of the same name
class Creature
  def initialize(name)
    @name = name
  end
  
  def fight		# parent method
    return "Punch to the chops!" 
  end
end

class Dragon < Creature
    def fight	# => "Instead of breathing fire... / Punch to the chops!"
        puts "Instead of breathing fire..."
        super  # this looks for a parent method of the name fight
    end
end


### Note: Ruby does not allow "multiple inheritance" -- where classes can have more than one parent
# does have something called mixins which comes later

class Computer
    @@users = {}		# class variable, accessed by the Class method Computer.get_users
    def initialize(username, password)
        @username = username
        @password = password
        @files = {}		# instance variable, used in create method
        @@users[username] = password 
    end
    def create(filename)
        @time = Time.now
        @files[filename] = @time
        puts "#{filename} was created at #{@time} by #{username}"
    end
    def Computer.get_users
        return @@users
    end
end

my_computer = Computer.new("gerald", 123)  # creates an instance of Computer with username Gerald, password 123.

### attr_reader, attr_writer, attr_accessor
class Person
  attr_reader :name
  attr_accessor :job  # replaces attr_writer :job; attr_reader :job
  
  def initialize(name, job)
    @name = name
    @job = job
  end
end


### MODULES
# much like classes, but no subclasses and can't create instances
# just used to store stuff
module Circle

  PI = 3.141592653589793
  
  def Circle.area(radius)
    PI * radius**2
  end
  
  def Circle.circumference(radius)
    2 * PI * radius
  end
end

# Modules are used for Namespacing. Ruby doesn't confuse Circle::PI with Math::PI
# :: is the "scope resolution operator"

# include Math   would let us use the module's methods and constants, so we could then reference PI instead of Math::PI

# A "mixin" is when a module is used to mix additional behavior/info into a class

# whereas "include" mixes a module's methods in at the instance level, 
#         "extend" mixes a module's methods in at the class level

# ThePresent has a .now method that we'll extend to TheHereAnd
module ThePresent
  def now
    puts "It's #{Time.new.hour > 12 ? Time.new.hour - 12 : Time.new.hour}:#{Time.new.min} #{Time.new.hour > 12 ? 'PM' : 'AM'} (GMT)."
  end
end

class TheHereAnd
  extend ThePresent  # now class TheHereAnd can use the method .now
end

TheHereAnd.now

# Another example
module Languages
  FAVE = "Ruby"
end

class Master
include Languages
  def initialize; end
  def victory
    puts FAVE	# accessible b/c we included module Languages
  end
end

total = Master.new
total.victory   # => "Ruby"

# 1_000_000 is allowed by ruby, for readability of large numbers


