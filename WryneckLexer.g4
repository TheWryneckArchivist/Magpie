lexer grammar WryneckLexer;

// === RESERVED KEYWORDS ===
VERSION_KEY   : '_version' ;
IMPORT        : 'import' ;
MACRO         : 'macro' ;
RESOURCE      : 'resource' ;
DEPRECATED    : 'deprecated' ;
STABLE        : 'stable' ;
EXPERIMENTAL  : 'experimental' ;
PATH          : 'path' ;
LOAD          : 'load' ;
EXTENDS       : 'extends' ;
AS            : 'as' ;
CONST         : 'const' ;
IF            : 'if' ;
ELSE          : 'else' ;


// === VERSION TOKENS ===
VERSION_LITERAL : [0-9]+ ('.' [0-9]+)+ ;


// === PRIMITIVE DATA TYPES ===
INT       : [0-9]+ ;
FLOAT     : [0-9]+ '.' [0-9]* ;
BOOLEAN   : 'true' | 'false' ;
DIMENSION : [0-9]+ 'x' [0-9]+ ;


// === STRINGS WITH ADVANCED INTERPOLATION ---
// Single-line or multi-line strings with support for interpolation and formatting.
// Interpolations of the form: ${ expression (COMMA expression)* (COLON formatSpecifier)? }
STRING 
    : '"' (ESCAPED_CHAR | ~["\\$])* (INTERP)* '"' 
    | '"""' (ESCAPED_CHAR | .)*? '"""'
    ;
fragment INTERP 
    : '${' expression (COMMA expression)* (COLON formatSpecifier)? '}'
    ;
fragment formatSpecifier 
    : 'upper'
    | 'lower'
    | 'title'
    | 'currency'
    | 'date'
    ;


// === ASSET PATTERNS ===
ASSET_PATTERN 
    : [a-zA-Z_]+ '{' INT '...' INT '}' [a-zA-Z0-9_.]+
    ;


// === SYMBOLS AND DELIMITERS ===
EQUAL      : '=' ;
ARROW      : '=>' ;
COLON      : ':' ;
COMMA      : ',' ;
PIPE       : '|' ;
ELLIPSIS   : '...' ;
PLUS       : '+' ;
MINUS      : '-' ;
STAR       : '*' ;
DIV        : '/' ;

METADATA_START : '#[' ;
METADATA_END   : ']' ;

LA_BRACKET : '[' ;
RA_BRACKET : ']' ;
LC_BRACE   : '{' ;
RC_BRACE   : '}' ;
L_PAREN    : '(' ;
R_PAREN    : ')' ;

AT         : '@' ;


// === IDENTIFIERS ===
ID : [a-zA-Z_][a-zA-Z_0-9]* ;


// === COMMENTS ===
HASH_COMMENT : '#' ~[\r\n]* ;
COMMENT_BLOCK : '/*' .*? '*/' -> skip ;


// === WHITESPACE AND NEWLINES ===
NEWLINE : [\r\n]+ ;
WS : [ \t]+ -> skip ;


// === NUMBER (for INT and FLOAT as literal) ---
NUMBER : [0-9]+ ('.' [0-9]+)? ;


// === ESCAPED CHARACTERS ---
fragment ESCAPED_CHAR : '\\' . ;
