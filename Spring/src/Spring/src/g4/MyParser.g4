parser grammar MyParser;

options { tokenVocab = MyLexer; }



// file structure 
fileNode : compoundStatement EOF
    ; 

expression
    : simpleExpression
    ( (EQUAL | NOT_EQUAL | LT | LE | GE | GT | IN) simpleExpression )*
    ;

simpleExpression
    : setOP
    | term ( (PLUS | MINUS | OR | XOR) term )*
    ;

term
    : (PLUS | MINUS)? factor (
     (MULT | SLASH | DIV | MOD | AND | (LSHIFT2 | LSHIFT) | (RSHIFT2 | RSHIFT) | (MULT MULT)
     ) (PLUS | MINUS)? factor )*
    ;

setOP 
    : set ((PLUS | MINUS | MULT | (GT LT) | (GT EQUAL) | (LT EQUAL)) set )*
    ;

factor
    : variable
    | functionDesignator
    | LPAREN expression RPAREN
    | unsignedConstant
    | NOT factor
    ;

set
    : LBRACK (setContainer (COMMA setContainer)*)? RBRACK   
    | LBRACK2 (setContainer (COMMA setContainer)*)? RBRACK2 
    ;

setContainer 
    : expression (DOTDOT expression)?
    ;


functionDesignator
    : (identifier | UNALIGNED)  LPAREN parameterList? RPAREN
    ;


// params 
parameterList
    : actualParameter ( COMMA actualParameter )*
    ;

actualParameter
    : expression (COLON unsignedInteger)?
    ;


 
identifier
    : IDENT
    ;

label
    : identifier 
    | unsignedInteger
    ;

unsignedNumber
    : unsignedInteger
    | unsignedReal
    ;

unsignedInteger
    : NUM_INT
    ;

unsignedReal
    : NUM_REAL
    ;




// statements     
compoundStatement
    : BEGIN statements SEMI? END
    ;

statement
    : label COLON unlabelledStatement
    | unlabelledStatement
    ;

unlabelledStatement
    : simpleStatement
    | structuredStatement
    ;

structuredStatement
    : compoundStatement
    | conditionalStatement
    | repetetiveStatement
    | withStatement
    ;


gotoStatement
    : GOTO label
    ;
    
emptyStatement
    :
    ;


simpleStatement
    : assignmentStatement
    | functionDesignator
    | labeledStatement
    | gotoStatement
    | identifier
    | PASS 
    | emptyStatement
    ;

labeledStatement 
    : LABEL label ( COMMA label )* 
    ;

assignmentStatement
    : variable (ASSIGN | (assignmentVariants '=')) expression
    ;

assignmentVariants
    : PLUS
    | MINUS 
    | MULT 
    | SLASH
    ;

variable
    : variableVariants
      ( LBRACK expression ( COMMA expression)* RBRACK
      | LBRACK2 expression ( COMMA expression)* RBRACK2
      | DOT identifier
      | POINTER
      )*
    ;

variableVariants 
    : 
    identifier
    | AT expression
    | AT identifier 
    | functionDesignator
    ;

statements
    : statement ( SEMI statement )* 
    ;

conditionalStatement
    : ifStatement
    | caseStatement
    ;

ifStatement
    : IF expression THEN statement
      (
     ELSE statement
    )?
    ;

caseStatement 
    : CASE expression OF
        caseListElement ( SEMI caseListElement )* SEMI?
      ( (ELSE | OTHERWISE) statements )?
      END
    ;

caseListElement
    : constList COLON statement
    ;

constList
    : constant (DOTDOT constant)? ( COMMA constant (DOTDOT constant)?)*
    ;

// constansts 
constant
    : unsignedNumber
    | identifier
    | STRING_LITERAL
    | constantChr
    ;
    
constantChr
    : CHR LPAREN (unsignedInteger|identifier) RPAREN
    ;

unsignedConstant
    : unsignedNumber
    | constantChr  
    | STRING_LITERAL
    | NIL
    ;


repetetiveStatement
    : whileStatement
    | repeatStatement
    | forStatement
    ;

whileStatement
    : WHILE expression DO statement
    ;

repeatStatement
    : REPEAT statements UNTIL expression
    ;

forStatement
    : 
    FOR identifier ASSIGN forList DO statement
    | FOR identifier IN expression DO statement
    ;


forList
    : initialValue (TO | DOWNTO) finalValue
    ;

withStatement
    : WITH varList DO statement
    ;

varList
    : variable ( COMMA variable )*
    ;


initialValue
    : expression
    ;

finalValue
    : expression
    ;
    
 

