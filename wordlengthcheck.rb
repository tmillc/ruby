print "Enter a word: "
word1 = String(gets.chomp)

print "Now enter another word: "
word2 = String(gets.chomp)

if word1.length > word2.length
    print "First word is longer"
elsif word1.length < word2.length
    print "Second word is longer"
else
    print "They're the same length"
end

def whichbefore(word1, word2)
  if word1 <=> word2 == -1
    puts "#{word1} comes first"
  elsif word1 <=> word2 == 0
    puts "They're the same word"
  else
    puts "#{word2} comes first"
  end
end
