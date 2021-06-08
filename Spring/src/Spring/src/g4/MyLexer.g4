lexer grammar MyLexer;


WS  
 : 
    ( ' '
    |  '\t'
    |  '\f'
    |  (  '\r\n'  
      |  '\r'   
      |  '\n' 
      )
      {  }
    )
    -> channel(HIDDEN)
  ;


AND :  'and';
ARRAY :  'array' ;
BEGIN :  'begin';
BOOLEAN :  'boolean';
CASE :  'case';
CHAR :  'char' ;
CHR  :  'chr';
EXIT :   'exit' ;
CONST :  'const';
DIV :   'div';
DO :   'do' ;
DOWNTO :  'downto';
ELSE  :   'else';
OTHERWISE : 'otherwise';
END  :   'end';
FILE  :  'file';
FOR :   'for';
FORWARD :  'forward' ;
FUNCTION :   'function' ;
GOTO  :   'goto' ;
IF :  'if' ;
IN  :  'in' ;
INTEGER :  'integer' ;
LABEL :  'label' ;
MOD  :   'mod';
NIL :  'nil' ;
NOT :  'not';
OF  :  'of';
OR :  'or' ;
XOR : 'xor';
PACKED : 'packed' ;
PROCEDURE  :  'procedure';
PROGRAM  :  'program';
REAL :  'real';
RECORD :  'record' ;
REPEAT :   'repeat';
SET :   'set';
THEN  :  'then' ;
TO :   'to' ;
TYPE :  'type';
UNTIL :  'until';
VAR  :   'var';
WHILE  :  'while' ;
WITH :  'with';
UNIT :  'unit';
INTERFACE :  'interface';
USES :  'uses' ;
STRING  :   'string' ;
PASS : 'pass';
  
PLUS : '+';
MINUS : '-';
MULT : '*';
SLASH : '/';
ASSIGN : ':=';
COMMA : ',';
SEMI : ';';
COLON : ':' ;
LSHIFT : '<<';
RSHIFT : '>>';
LSHIFT2 : 'shl';
RSHIFT2 : 'shr';
EQUAL : '=' ;
NOT_EQUAL : '<>';
LT : '<';
LE : '<=' ;
GE : '>=' ;
GT  : '>' ;
LPAREN :'(';
RPAREN : ')';
LBRACK : '['  ;  
LBRACK2 : '(.';  
RBRACK  :']';
RBRACK2 : '.)' ;
POINTER : '^'  ;
AT :'@';
DOT : '.' ;
DOTDOT : '..';
LCURLY  : '{' ;
RCURLY : '}' ;  
STRING_LITERAL
  : '\'' ('\'\'' | ~('\''))* '\''   
  ;
//BAD_CHARACTER: .;

IDENT  :  ('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*   
  ;


// force to separate lexer and parser 
NUM_INT : 
  INT_N | NUM_REAL 
  ;
  
fragment 
INT_N 
  : 
  DEC_NUM+
  | '%' BIN_NUM
  | '$' HEX_NUM
  | '&' OCT_NUM
  ;

fragment
SIGN_NUM 
  : 
  ('+' | '-')? NUM_INT
  ;
  
NUM_REAL
  : 
  DEC_NUM+ FLOATING_P? EXPONENT?
  ;

fragment
DEC_NUM 
   :  '0' .. '9';
   
fragment 
HEX_NUM 
   :  [0-9a-fA-F];
   
fragment
OCT_NUM 
   : '0' .. '7';
   
fragment 
BIN_NUM 
   : 
   '0' 
   | '1'
   ;



//NUM_INT
//  : ('0'..'9')+ 
//    ( 
//      (
//        {(input.LA(2)!='.')&&(input.LA(2)!=')')}? => FLOATING_P
//      )?
//    | EXPONENT {$type = NUM_REAL;}  
//    )
//  ;

fragment
EXPONENT
  :  ('e' | 'E') ('+'|'-')? DEC_NUM+
  ;

fragment 
FLOATING_P 
  : 
  '.'  ('0'..'9')+ (EXPONENT)?
  ;


SINGLE_COMMENT
  : 
  '//' ~[\r\n]* 
  -> channel(HIDDEN)
  ;

fragment 
CommentClass 
  : COMMENT_1 
  | COMMENT_2
  ; 

COMMENT_1 
  : '(' '*' (CommentClass | . )*? '*' ')' 
  -> channel(HIDDEN);

COMMENT_2
  :  '{'
        (  ~('}') )*
           '}'
    -> channel(HIDDEN)
  ;

