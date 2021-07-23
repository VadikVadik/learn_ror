alphabet = ("a".."z").to_a
vowels = {}

alphabet.each do |letter|
  if "aeiouy".include?(letter)
    vowels[letter] = alphabet.index(letter) + 1
  end
end

puts vowels
