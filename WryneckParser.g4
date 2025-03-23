parser grammar WryneckParser;  
options { tokenVocab=WryneckLexer; }

// === ROOT RULE ===
// Entry point for parsing the configuration file
file 
    : statement* EOF
    ;

statement
    : versionField                     // Version specification
    | importStatement                  // Import with optional condition and alias
    | constant                         // Global constants
    | assignment                       // Simple assignments (with type annotations)
    | computedProperty                 // Computed properties (using "=>")
    | macro                            // Macro definitions (with parameters and variadic support)
    | resourceReference                // Resource references
    | versionControlStatement          // Version control statements (e.g., stable, deprecated)
    | conditional                      // Conditional blocks (if-else)
    | metadata                         // Tagged metadata
    | comment                          // Comments
    ;


// === VERSION FIELD ===
// Specifies the version of the configuration file
versionField 
    : VERSION_KEY EQUAL versionLiteral NEWLINE
    ;
versionLiteral 
    : VERSION_LITERAL
    ;


// === IMPORT STATEMENTS ===
// Handles importing external configurations with optional aliases and conditions
importStatement 
    : IMPORT LA_BRACKET (configFileAlias (COMMA configFileAlias)*)? RA_BRACKET (IF L_PAREN expression R_PAREN)? NEWLINE
    ;
configFileAlias 
    : configFile (AS ID)? 
    ;
configFile 
    : ID | STRING 
    ;


// === CONSTANTS ===
// Defines immutable global values
constant
    : CONST ID EQUAL expression NEWLINE
    ;


// === ASSIGNMENTS ===
// Defines key-value assignments, with optional type annotations
assignment 
    : metadata* ID (COLON type)? EQUAL expression NEWLINE
    ;


// === COMPUTED PROPERTIES ===
// Dynamic properties computed via an arrow (=>)
computedProperty
    : metadata* ID EQUAL ARROW expression NEWLINE
    ;


// === MACROS ===
// Defines reusable configuration blocks with parameters (supporting variadic arguments)
macro 
    : metadata* MACRO ID L_PAREN paramList? R_PAREN (EXTENDS ID)? LC_BRACE macroBody RC_BRACE
    ;
paramList
    : param (COMMA param)* (COMMA ELLIPSIS ID)?
    ;
param 
    : ID (EQUAL expression)?
    ;
macroBody 
    : statement*
    ;


// === RESOURCE REFERENCES ===
// Links external resources such as files or assets
resourceReference 
    : metadata* RESOURCE ID EQUAL STRING (attribute)* NEWLINE
    ;


// === VERSION CONTROL ===
// Handles version control markers with optional attributes
versionControlStatement 
    : versionControlType ID (attribute)* NEWLINE
    ;
versionControlType 
    : STABLE | DEPRECATED | EXPERIMENTAL
    ;


// === CONDITIONAL BLOCKS ===
// Supports if/else blocks for dynamic configurations
conditional 
    : IF L_PAREN expression R_PAREN LC_BRACE statement* RC_BRACE (ELSE LC_BRACE statement* RC_BRACE)?
    ;


// === ANNOTATED METADATA ---
// Tagged metadata using the #[ ... ] syntax
metadata 
    : METADATA_START ID (COMMA ID)* METADATA_END NEWLINE
    ;


// === COMMENTS ===
// Parses single-line or multi-line comments
comment 
    : HASH_COMMENT 
    | COMMENT_BLOCK
    ;


// === EXPRESSIONS ===
// Handles calculations, lambda expressions, variable references, and string interpolation
expression 
    : primaryExpression (operator primaryExpression)*
    ;
primaryExpression 
    : literal
    | variable
    | lambdaExpr
    | '(' expression ')'
    | list
    | dictionary
    ;


// --- Lambda-like expression ---
// Syntax: | paramList | expression
lambdaExpr 
    : PIPE paramList PIPE expression
    ;


// --- List (Array) ---
// Supports lists of expressions
list 
    : LA_BRACKET (expression (COMMA expression)*)? RA_BRACKET
    ;


// --- Dictionary ---
// Supports key-value pairs in configuration blocks
dictionary 
    : LC_BRACE (keyValuePair (COMMA keyValuePair)*)? RC_BRACE
    ;
keyValuePair 
    : ID COLON expression
    ;


// === TYPES ---
// Type annotations for assignments
type 
    : 'int'
    | 'float'
    | 'bool'
    | 'string'
    | 'dimension'
    ;


// === MATH OPERATORS ---
// Arithmetic operators
operator 
    : PLUS 
    | MINUS 
    | STAR 
    | DIV
    ;


// === LITERALS AND VARIABLES ---
// Handles values like strings, numbers, booleans, and asset patterns
literal 
    : STRING 
    | NUMBER 
    | BOOLEAN 
    | ASSET_PATTERN
    ;
variable 
    : ID
    ;
