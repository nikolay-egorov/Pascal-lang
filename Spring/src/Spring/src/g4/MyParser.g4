parser grammar MyParser;

options { tokenVocab = MyLexer; }

tokens {
  PROC_CALL,
  BAD_CHARACTER
}
 
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


// file structure 
fileNode : compoundStatement? EOF
    ; 

expression
    : simpleExpression
    ( (EQUAL? | NOT_EQUAL? | LT? | LE? | GE? | GT? | IN?) simpleExpression )*
    ;

simpleExpression
    : term ( (PLUS? | MINUS? | OR?) term )*
    ;

term
    : (PLUS | MINUS)? factor ( (MULT? | SLASH? | DIV? | MOD? | AND?) (PLUS | MINUS)? factor )*
    ;


factor
    : variable
    | functionDesignator
    | LPAREN expression RPAREN
    | unsignedConstant
    | set
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
    : identifier WS? LPAREN parameterList? RPAREN
    ;


// params 
parameterList
    : actualParameter ( COMMA actualParameter )*
    ;

actualParameter
    : expression (COLON unsignedInteger)?
    ;



// statements     
compoundStatement
    : BEGIN
    statements
      END
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


callPart 
   : (PROC_CALL identifier parameterList?)
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
    : variable ((assignmentVariants '=') | ASSIGN) expression
    ;

assignmentVariants
    : PLUS
    | MINUS 
    | MULT 
    | SLASH
    ;

variable
    : ( AT identifier 
      | AT expression
      | identifier
      | functionDesignator
      )
      ( LBRACK expression ( COMMA expression)* RBRACK
      | LBRACK2 expression ( COMMA expression)* RBRACK2
      | DOT identifier
      | POINTER
      )*
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
    : CHRLPAREN (unsignedInteger|identifier) RPAREN
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
    
 

