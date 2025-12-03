require "./lexer.cr"

content : String = File.read("./example.txt")
lexer = Lexer.new(content)

while f = lexer.next()
    puts f
end

#chars : Iterator(Char) = content.each_char
#chars.with_index { |ch, i|
#    if ch == '\n'
#        puts "Newline at ", i 
#    end
#}