lexer grammar MagpieLexer;

// Reserved keywords
VERSION_KEY   : 'version' ;      // Keyword for specifying the version of the configuration
IMPORT        : 'import' ;        // For importing other configuration files
MACRO         : 'macro' ;         // Define macros for reusable configuration blocks
RESOURCE      : 'resource' ;      // Reference external resources like files or assets
DEPRECATED    : 'deprecated' ;    // Mark a configuration as deprecated
STABLE        : 'stable' ;        // Mark a configuration as stable
EXPERIMENTAL  : 'experimental' ;  // Mark a configuration as experimental
PATH          : 'path' ;          // Specify file paths
LOAD          : 'load' ;          // For loading external resources or configurations
EXTENDS       : 'extends' ;       // Inherit configurations from other macros
AS            : 'as' ;            // Alias for a configuration or resource
CONST         : 'const' ;         // Define constant values
IF            : 'if' ;            // Start of conditional blocks
ELSE          : 'else' ;          // Alternate branch in conditional blocks
INFIX         : 'infix' ;         // Define custom infix operators
INCLUDE       : 'include' ;       // Include external configuration files
FOR           : 'for' ;           // Used in loops and list comprehensions
IN            : 'in' ;            // Used in loops and list comprehensions
TO            : 'to' ;            // Used for unit conversions

// Version tokens
VERSION_LITERAL : [0-9]+ ('.' [0-9]+)+ ;

// Primitive data types
INT       : [0-9]+ ;              // Integer numbers
FLOAT     : [0-9]+ '.' [0-9]* ;   // Floating-point numbers
BOOLEAN   : 'true' | 'false' ;    // Boolean values
DIMENSION : [0-9]+ 'x' [0-9]+ ;   // Dimensions in format 1920x1080
STRING : '"' (ESCAPED_CHAR | ~["\\$])* (INTERP)* '"' | '"""' (ESCAPED_CHAR | .)*? '"""' ;
fragment INTERP : '${' expression (COMMA expression)* (COLON formatSpecifier)? '}' ;  // Interpolation inside strings
fragment formatSpecifier : 'upper' | 'lower' | 'title' | 'currency' | 'date' ;        // String formatting options

// Asset pattern
ASSET_PATTERN : [a-zA-Z_]+ '{' INT '...' INT '}' [a-zA-Z0-9_.]+ ;

// Symbols and delimiters
EQUAL      : '=' ;                // Assignment operator
ARROW      : '=>' ;               // Used for computed properties or dynamic assignment
COLON      : ':' ;                // Separator for key-value pairs
COMMA      : ',' ;                // Separator for list or argument items
PIPE       : '|' ;                // For piping values or functions
ELLIPSIS   : '...' ;              // Spread operator for ranges or sequences
PLUS       : '+' ;                // Addition operator
MINUS      : '-' ;                // Subtraction operator
STAR       : '*' ;                // Multiplication operator
DIV        : '/' ;                // Division operator
METADATA_START : '#[' ;           // Start of metadata annotations
METADATA_END   : ']' ;            // End of metadata annotations
LA_BRACKET : '[' ;                // Left square bracket
RA_BRACKET : ']' ;                // Right square bracket
LC_BRACE   : '{' ;                // Left curly brace
RC_BRACE   : '}' ;                // Right curly brace
L_PAREN    : '(' ;                // Left parenthesis
R_PAREN    : ')' ;                // Right parenthesis
AT         : '@' ;                // Used for annotations or references

// Identifier
ID : [a-zA-Z_][a-zA-Z_0-9]* ;

// Comments
HASH_COMMENT : '#' ~[\r\n]* ;            // Single-line comment
COMMENT_BLOCK : '/*' .*? '*/' -> skip ;  // Multi-line comment (skipped in parsing)

// Whitespace and newlines
NEWLINE : [\r\n]+ ;               // Line breaks
WS : [ \t]+ -> skip ;             // Skip whitespace characters

// Number
NUMBER : [0-9]+ ('.' [0-9]+)? ;   // General number format

// Escaped characters
fragment ESCAPED_CHAR : '\\' . ;  // Escape character handling (e.g., for quotes, backslashes)
