lexer grammar WryneckLexer;

// === RESERVED KEYWORDS ===
// Keywords defining specific configurations and grammar functionalities
VERSION_KEY : '_version' ; // Specifies the version field for the configuration
IMPORT : 'import' ; // Imports external configuration files
MACRO : 'macro' ; // Defines reusable blocks of configuration
RESOURCE : 'resource' ; // Links external resources like files or assets
DEPRECATED : 'deprecated' ; // Marks features as deprecated
STABLE : 'stable' ; // Marks features as stable and production-ready
EXPERIMENTAL : 'experimental' ; // Marks features as experimental
PATH : 'path' ; // Specifies directory paths in configurations
LOAD : 'load' ; // Dynamically loads resources or files during runtime
EXTENDS : 'extends' ; // Enables inheritance in macro definitions
AS : 'as' ; // Provides aliasing functionality for imports


// === VERSION TOKENS ===
// Tokens for specifying version information
VERSION_LITERAL : [0-9]+ ('.' [0-9]+)+ ; // Represents version numbers (e.g., 1.0, 2.1.3)


// === PRIMITIVE DATA TYPES ===
// Defines basic types supported by the configuration language
INT : [0-9]+ ; // Represents integer values (e.g., 42)
FLOAT : [0-9]+ '.' [0-9]* ; // Represents floating-point numbers (e.g., 3.14)
BOOLEAN : 'true' | 'false' ; // Boolean values (true or false)


// === STRINGS ===
// Defines single-line and multi-line strings, with optional interpolation
STRING : '"' (ESCAPED_CHAR | ~["\\$])* ('${' expression '}')* '"' | '"""' (ESCAPED_CHAR | .)*? '"""' ; // Multi-line string support


// === ASSET PATTERNS ===
// Defines patterns for external assets (e.g., ranges and filenames)
ASSET_PATTERN : [a-zA-Z_]+ '{' INT '...' INT '}' [a-zAZ0-9_.]+ ; // Asset definition with ranges


// === SYMBOLS ===
// Operators and delimiters used in syntax
EQUAL : '=' ; // Assignment operator
COLON : ':' ; // Key-value pair separator
COMMA : ',' ; // List item separator
PIPE : '|' ; // Represents alternatives in lists
ELLIPSIS : '...' ; // Indicates list expansion or ranges
PLUS : '+' ; // Arithmetic addition
MINUS : '-' ; // Arithmetic subtraction
STAR : '*' ; // Arithmetic multiplication
DIV : '/' ; // Arithmetic division
AT : '@' ; // Prefix for annotations


// === DELIMITERS ===
// Tokens for grouping or organizing sections
LA_BRACKET : '[' ; // Left square bracket for lists
RA_BRACKET : ']' ; // Right square bracket for lists
LC_BRACE : '{' ; // Left curly brace for macro or block definitions
RC_BRACE : '}' ; // Right curly brace for macro or block definitions
L_PAREN : '(' ; // Left parenthesis for annotation arguments
R_PAREN : ')' ; // Right parenthesis for annotation arguments

// === IDENTIFIERS ===
// Tokens for variable, macro, or resource identifiers
ID : [a-zA-Z_][a-zA-Z_0-9]* ; // Represents alphanumeric identifiers


// === COMMENTS ===
// Tokens for defining single-line and multi-line comments
HASH_COMMENT : '#' ~[\r\n]* ; // Single-line comments using "#"
COMMENT_BLOCK : '/*' .*? '*/' -> skip ; // Multi-line comments enclosed by "/* */"


// === WHITESPACE AND NEWLINES ===
// Tokens for spacing and line breaks, ignored during parsing
NEWLINE : [\r\n]+ ; // Matches newline characters
WS : [ \t]+ -> skip ; // Matches spaces and tabs, skipped in parsing


// === ESCAPED CHARACTERS ===
// Fragment for escape sequences used within strings
fragment ESCAPED_CHAR : '\\' [\"\\] ; // Handles escaped characters (e.g., \" or \\)
