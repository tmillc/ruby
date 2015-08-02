=begin
  String manipulation experiments
=end

print "Enter a string: "
user_input = gets.chomp.downcase

if user_input.include? "s"
  user_input.gsub!(/s/,"th")
else
  puts "There was no s"
end

puts "#{user_input}"


=begin ideas
  handle empty input
  deal better with capitilzation
  consider c's that sound like s's
=end
