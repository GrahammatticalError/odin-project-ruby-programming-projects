# caesar_cipher.rb
# This program will take a string as a message variable and an integer as a key variable. 
# All of the letters in the string will be shifted to other letters based on the key's value.

def caesar_cipher(message, key, result = '')
    message.each_char do |char|
        # determines if the char is uppercase or lowercase
        lowest = char.ord < 91 ? 65 : 97
        # shifts uppercase and lowercase characters
        if char.ord.between?(65, 90) || char.ord.between?(97,122)
            new_char = ((char.ord + key - lowest) % 26) + lowest
            result += new_char.chr
        else
            result += char
        end
    end
    p result
end

caesar_cipher('hello', 5)
#'mjqqt'