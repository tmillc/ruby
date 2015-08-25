frequencies = Hash.new(0)

puts "Enter some text: "
text = gets.chomp

words = text.split

words.each { |word| frequencies["#{word}"] +=1 }
frequencies = frequencies.sort_by do |word, count|
    count
end
frequencies.reverse!

frequencies.each do |word, freq|
    puts word + " " + freq.to_s
end
