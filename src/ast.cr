require "./lexer-pos.cr"
require "./token"

abstract class ASTNode
    getter pos : LexerPosition
end

def parse_scientific_notation(text : String) : Float64
    text.gsub('e', 'E').to_f64
end

class Number < ASTNode
    getter value : Float64

    def initialize(token : Token)
        super(token.pos)
        @value = parse_scientific_notation(token.span)
    end
end

class Identifier < ASTNode
    getter name : String
    
    def initialize(token : Token)
        super(token.pos)
        @name = token.span
    end
end

class BinaryOp < ASTNode
    getter left : ASTNode
    getter operator : Token
    getter right : ASTNode
    
    def initialize(@left, @operator, @right)
        super(@operator.pos)
    end
end

class UnaryOp < ASTNode
    getter operator : Token
    getter operand : ASTNode
    
    def initialize(@operator, @operand)
        super(@operator.pos)
    end
end

class Assignment < ASTNode
    getter identifier : Identifier
    getter value : ASTNode
    
    def initialize(@identifier, @value)
        super(@identifier.pos)
    end
end

class Program < ASTNode
    getter statements : Array(ASTNode)
    
    def initialize(@statements)
        super(@statements.first?.try(&.pos) || LexerPosition.new())
    end
end