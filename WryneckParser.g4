parser grammar WryneckParser;
options { tokenVocab=WryneckLexer; }

// === ROOT RULE ===
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
    | infixDefinition                  // Custom operator definitions
    | includeStatement                 // File inclusion statement
    | policyStatement                  // Security policy block
    | comment                          // Comments
    ;

versionField 
    : VERSION_KEY EQUAL versionLiteral NEWLINE
    ;
versionLiteral 
    : VERSION_LITERAL
    ;

// === IMPORT STATEMENTS ===
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
constant
    : CONST ID EQUAL expression NEWLINE
    ;

// === ASSIGNMENTS ===
assignment 
    : metadata* ID (COLON type)? EQUAL expression NEWLINE
    ;

// === COMPUTED PROPERTIES ===
computedProperty
    : metadata* ID EQUAL ARROW expression NEWLINE
    ;

// === MACROS ===
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
resourceReference 
    : metadata* RESOURCE ID EQUAL STRING (attribute)* NEWLINE
    ;

// === VERSION CONTROL STATEMENTS ===
versionControlStatement 
    : versionControlType ID (attribute)* NEWLINE
    ;
versionControlType 
    : STABLE | DEPRECATED | EXPERIMENTAL
    ;

// === CONDITIONAL BLOCKS ===
conditional 
    : IF L_PAREN expression R_PAREN LC_BRACE statement* RC_BRACE (ELSE LC_BRACE statement* RC_BRACE)?
    ;

// === ANNOTATED METADATA ---
metadata 
    : METADATA_START ID (COMMA ID)* METADATA_END NEWLINE
    ;

// === INFIX DEFINITION (Custom Operators) ===
infixDefinition
    : INFIX ID L_PAREN paramList? R_PAREN ARROW expression NEWLINE
    ;

// === FILE INCLUSION STATEMENT ===
includeStatement
    : INCLUDE STRING NEWLINE
    ;

// === SECURITY POLICY STATEMENT ===
policyStatement
    : POLICY LC_BRACE policyBody RC_BRACE NEWLINE
    ;
policyBody
    : (allowRule | denyRule)*
    ;
allowRule
    : ALLOW expression NEWLINE
    ;
denyRule
    : DENY expression NEWLINE
    ;

// === COMMENTS ===
comment 
    : HASH_COMMENT 
    | COMMENT_BLOCK
    ;

// === EXPRESSIONS ===
expression 
    : primaryExpression (operator primaryExpression)*
    ;

// --- MATH OPERATORS & Conversion Operator ---
operator 
    : PLUS 
    | MINUS 
    | STAR 
    | DIV
    | TO
    ;

// === PRIMARY EXPRESSIONS ===
primaryExpression 
    : literal
    | functionCall
    | variable
    | lambdaExpr
    | '(' expression ')'
    | list
    | dictionary
    ;

functionCall
    : ID L_PAREN (expression (COMMA expression)*)? R_PAREN
    ;

// --- Lambda-like expression ---
lambdaExpr 
    : PIPE paramList PIPE expression
    ;

// --- List (Array) with Optional Comprehension ---
list 
    : LA_BRACKET (expression (COMMA expression)*)? (FOR ID IN expression (IF expression)?)? RA_BRACKET
    ;

// --- Dictionary ---
dictionary 
    : LC_BRACE (keyValuePair (COMMA keyValuePair)*)? RC_BRACE
    ;
keyValuePair 
    : ID COLON expression
    ;

// === TYPES ===
type 
    : 'int'
    | 'float'
    | 'bool'
    | 'string'
    | 'dimension'
    ;

// === LITERALS AND VARIABLES ===
literal 
    : STRING 
    | NUMBER 
    | BOOLEAN 
    | ASSET_PATTERN
    ;
variable 
    : ID
    ;

// === ATTRIBUTE (for resource references) ===
attribute
    : ID EQUAL expression
    ;
