movies = { 
    Dogs: 3
}

puts "Gimme some input: "
choice = gets.chomp

case choice
when "add"
  puts "What's the title?"
  title = gets.chomp
  puts "Rating?"
  rating = gets.chomp
  if movies[title.to_sym] == nil
      movies[title.to_sym] = rating.to_i
      puts "Added"
  else
      puts "Movie already exists"
  end
when "update"
  puts "Enter the title"
  title = gets.chomp
  if movies[title.to_sym] == nil
      puts "It's not in there"
  else
      puts "Enter the new rating"
      rating = gets.chomp
      movies[title.to_sym] = rating.to_i
  end
when "display"
  movies.each { |movie, rating| puts "#{movie}: #{rating}" }
when "delete"
  puts "Which movie to delete?"
  title = gets.chomp
  if movies[title.to_sym] == nil
      puts "It's not in there"
  else
      movies.delete(title.to_sym)
      puts "Deleted"
  end
else
  puts "Error!"
end
