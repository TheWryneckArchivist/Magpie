parser grammar WryneckParser; 
options { tokenVocab=WryneckLexer; }

// === ROOT RULE ===
// Entry point for parsing the configuration file
file : (versionField // Handles version specifications
       | importStatement // Processes import statements for external files
       | entry // Parses configurations like assignments and macros
       | resourceReference // Links external resources
       | macro // Defines reusable macros, including polymorphic macros
       | versionControlStatement // Processes statements for version control (e.g., stable, deprecated)
)* EOF ; // Ensures the file ends properly


// === VERSION FIELD ===
// Specifies the version of the configuration file
versionField : VERSION_KEY EQUAL versionLiteral NEWLINE ;
versionLiteral : VERSION_LITERAL ; // Version values like 1.0.0 or 2.1


// === IMPORT STATEMENTS ===
// Handles importing external configurations with optional aliases
importStatement : IMPORT LA_BRACKET (configFileAlias (COMMA configFileAlias)*)? RA_BRACKET NEWLINE ;
configFileAlias : configFile (AS ID)? ; // File name with optional alias
configFile : ID | STRING ; // File name as an identifier or string


// === ENTRIES ===
// Defines general configurations (assignments, macros, attributes, comments)
entry : annotation* (assignment | macro | resourceReference | attribute | comment | versionControlStatement) ;


// === COMMENTS ===
// Parses single-line or multi-line comments
comment : HASH_COMMENT | COMMENT_BLOCK ;


// === ASSIGNMENTS ===
// Defines key-value assignments
assignment : annotation* ID EQUAL expression ;


// === EXPRESSIONS ===
// Handles calculations, variable references, and string interpolation
expression : primaryExpression (operator primaryExpression)* ;
primaryExpression : literal | variable | '(' expression ')' ; // Grouped expressions


// === ATTRIBUTES ===
// Represents metadata attributes attached to configurations
attribute : META_START ID (EQUAL literal)? META_END NEWLINE ;


// === MATH EXPRESSIONS ===
// Defines arithmetic operations for expressions
operator : PLUS | MINUS | STAR | DIV ; // Arithmetic operators (+, -, *, /)


// === LITERALS AND VARIABLES ===
// Handles values like numbers, strings, or boolean variables
literal : STRING | NUMBER | BOOLEAN | ASSET_PATTERN ;
variable : ID // Reference to identifiers ;


// === LISTS ===
// Supports lists of values, variables, or expressions
list : LA_BRACKET (elementList)? RA_BRACKET ;
elementList : element (COMMA element)* (PIPE element)* (ELLIPSIS element)? ;
element : literal | variable | expression ;


// === MACROS ===
// Defines reusable configuration blocks, supporting nested and polymorphic macros
macro : annotation* MACRO ID (EXTENDS ID)? LC_BRACE macroBody RC_BRACE ;
macroBody : (assignment | macro | attribute)* ;


// === RESOURCE REFERENCES ===
// Links external resources like files or assets
resourceReference : annotation* RESOURCE ID EQUAL STRING (attribute)* NEWLINE ;


// === VERSION CONTROL ===
// Handles version control markers with optional metadata
versionControlStatement : versionControlType ID (attribute)* NEWLINE ;
versionControlType : STABLE | DEPRECATED | EXPERIMENTAL ; // Defines the state of a feature


// === ANNOTATIONS ===
// Allows metadata annotations prefixed with '@'
annotation : AT ID (LPAREN annotationArgs? RPAREN)? NEWLINE ;

annotationArgs : annotationArg (COMMA annotationArg)* ;
annotationArg : literal | variable | expression ;
