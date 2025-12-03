class LexerPosition
    getter column
    getter line
    getter i

    def initialize()
        @column = 0
        @line = 1
        @i = 0  
    end
    
    def initialize(other : self)
        @column = other.column
        @line = other.line
        @i = other.i
    end

    def advance(ch : Char)
        @i += 1
        @column += 1
        if ch == '\n'
            @line += 1
            @column = 0
        end
    end

    def advance(n : Int)
        @i += n
        @column += n
    end
end