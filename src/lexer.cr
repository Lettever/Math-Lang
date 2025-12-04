require "./assert.cr"
require "./token.cr"
require "./lexer-pos.cr"

class Lexer
    @input : String
    @pos = LexerPosition.new()
    
    def initialize(input : String)
        @input = input
    end

    def peek(n : Int) : Char
        if @pos.i + n >= @input.size
            return '\0'
        end
        return @input[@pos.i + n]
    end

    def collect() : Array(Token)
        res : Array(Token)
        while f = self.next()
            res << f
        end
        return res
    end
    
    def next() : Token | Nil
        if @pos.i >= @input.size
            return nil
        end
        
        ch = @input[@pos.i]
        if TOKEN_MAP.has_key?(ch)
            token = Token.new(TOKEN_MAP[ch], ch.to_s(), LexerPosition.new(@pos))
            @pos.advance(ch)
        elsif ch.ascii_whitespace?
            @pos.advance(ch)
            i = 0
            while (ch = peek(i)).ascii_whitespace? && ch != '\n'
                @pos.advance(ch)
                i += 1
            end
            return self.next()
        elsif ch.ascii_letter?
            span = ch.to_s()
            while (ch = peek(span.size)).ascii_alphanumeric?
                span += ch
            end
            token = Token.new(:Ident, span, LexerPosition.new(@pos))
            @pos.advance(span.size)
        elsif ch.ascii_number?
            span, isValid = lex_num()
            type = if isValid
                TokenType::Num
            else
                TokenType::Error
            end
            token = Token.new(type, span, LexerPosition.new(@pos))
            @pos.advance(span.size)
        else
            token = Token.new(:Error, ch.to_s(), LexerPosition.new(@pos))
            @pos.advance(ch)
        end
        return token
    end

    def lex_num() : Tuple(String, Bool)
        assert @input[@pos.i].ascii_number?
        
        span = @input[@pos.i].to_s()
        while (ch = peek(span.size)).ascii_number?
            span += ch
        end

        if (ch = peek(span.size)) == '.'
            span += ch
            unless (ch = peek(span.size)).ascii_number?
                return {span, false}
            end
            while (ch = peek(span.size)).ascii_number?
                span += ch
            end
        end

        if (ch = peek(span.size)).downcase == 'e'
            span += ch
            if (ch = peek(span.size)).in?('+', '-')
                span += ch
            end
            unless (ch = peek(span.size)).ascii_number?
                return {span, false}
            end
            while (ch = peek(span.size)).ascii_number?
                span += ch
            end    
        end
        
        return {span, true}
    end
end