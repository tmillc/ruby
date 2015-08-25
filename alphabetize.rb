def alphabetize(arr, rev=false)
    arr.sort!
    if rev == true
      arr.reverse!
    end
    return arr
end

numbers = [3,4,2,3]

puts alphabetize(numbers)
