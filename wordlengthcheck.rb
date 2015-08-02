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
