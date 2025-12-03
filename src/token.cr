enum TokenType
    Plus
    Minus
    Times
    Divide
    Left_Paran
    Right_Paran
    Ident
    Num
    Error
    NewLine
    Equal
end

record Token, type : TokenType, span : String, pos : LexerPosition

TOKEN_MAP = {
    '+' => TokenType::Plus,
    '-' => TokenType::Minus,
    '*' => TokenType::Times,
    '/' => TokenType::Divide,
    '(' => TokenType::Left_Paran,
    ')' => TokenType::Right_Paran,
    '\n' => TokenType::NewLine,
    '=' => TokenType::Equal,
}