require "./lexer.cr"

content : String = File.read("./example.txt")
lexer = Lexer.new(content)

while f = lexer.next()
    if f.type == TokenType::Num || f.type == TokenType::Ident
        puts f
    end
end

#chars : Iterator(Char) = content.each_char
#chars.with_index { |ch, i|
#    if ch == '\n'
#        puts "Newline at ", i 
#    end
#}