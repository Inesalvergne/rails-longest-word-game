attempt = "testing"
# word = attempt.chars


# puts word.all? {|l| letters.include?(l)}


# array_of_letters = ('A'..'Z').to_a
# letters = 10.times.map { array_of_letters.sample }
# p letters.to_a


def in_grid?(attempt)
  letters = ["t", "e", "s", "t", "i", "n", "a", "b", "c"]
  attempt = attempt.chars
  attempt.all? { |l| letters.to_a.include?(l) }
end

puts in_grid?(attempt)
