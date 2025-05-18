parser grammar MagpieParser;  
options { tokenVocab=MagpieLexer; }  

// ROOT RULE
/* The entry point for parsing the configuration file. This will parse multiple statements until the end of the file. */
file : statement* EOF ;  

// STATEMENTS
/* A statement can be any one of the various configuration elements, such as constants, imports, or conditionals. */
statement : versionField | importStatement | constant | assignment | computedProperty | macro | resourceReference | versionControlStatement | conditional | metadata | infixDefinition | includeStatement | policyStatement | cryptoStatement | sysenvStatement | comment ;  

// VERSION FIELD
/* Defines the version of the configuration file using the 'version' keyword. */
versionField : VERSION_KEY EQUAL versionLiteral NEWLINE ;  
versionLiteral : VERSION_LITERAL ;  // The version number format

// IMPORT STATEMENTS
/* Handles importing external configuration files or modules, optionally with conditions and aliases. */
importStatement : IMPORT LA_BRACKET (configFileAlias (COMMA configFileAlias)*)? RA_BRACKET (IF L_PAREN expression R_PAREN)? NEWLINE ;  
configFileAlias : configFile (AS ID)? ;  
configFile : ID | STRING ;  // Can be a file ID or a string representing a file path

// CONSTANTS
/* Defines constants that cannot be changed once set. */
constant : CONST ID EQUAL expression NEWLINE ;  

// ASSIGNMENTS
/* Used to assign values to variables or configuration properties, with optional type annotations. */
assignment : metadata* ID (COLON type)? EQUAL expression NEWLINE ;  

// COMPUTED PROPERTIES 
/* Defines properties that are calculated dynamically based on other values. */
computedProperty : metadata* ID EQUAL ARROW expression NEWLINE ;  

// MACROS
/* Defines reusable blocks of configuration that can be parameterized and inherited. */
macro : metadata* MACRO ID L_PAREN paramList? R_PAREN (EXTENDS ID)? LC_BRACE macroBody RC_BRACE ;  
paramList : param (COMMA param)* (COMMA ELLIPSIS ID)? ;  // Parameter list with support for variadic parameters
param : ID (EQUAL expression)? ;  // Parameters with optional default values
macroBody : statement* ;  // Body of the macro, which can contain multiple statements

// RESOURCE REFERENCES
/* Links external resources such as files, assets, or other configurations. */
resourceReference : metadata* RESOURCE ID EQUAL STRING (attribute)* NEWLINE ;  

// VERSION CONTROL STATEMENTS
/* Specifies the version status of the configuration (e.g., stable, experimental). */
versionControlStatement : versionControlType ID (attribute)* NEWLINE ;  
versionControlType : STABLE | DEPRECATED | EXPERIMENTAL ;  

// CONDITIONAL BLOCKS
/* Defines if-else blocks to adapt the configuration based on conditions. */
conditional : IF L_PAREN expression R_PAREN LC_BRACE statement* RC_BRACE (ELSE LC_BRACE statement* RC_BRACE)? ;  

// ANNOTATED METADATA
/* Metadata annotations for categorizing or tagging configuration properties. */
metadata : METADATA_START ID (COMMA ID)* METADATA_END NEWLINE ;  

// INFIX DEFINITION (Custom Operators)
/* Allows the definition of custom operators (e.g., for arithmetic or logic). */
infixDefinition : INFIX ID L_PAREN paramList? R_PAREN ARROW expression NEWLINE ;  

// FILE INCLUSION STATEMENT
/* Handles including external configuration files within the current configuration. */
includeStatement : INCLUDE STRING NEWLINE ;  

// SECURITY POLICY STATEMENT
/* Defines access control policies for the configuration. */
policyStatement : POLICY LC_BRACE policyBody RC_BRACE NEWLINE ;  
policyBody : (allowRule | denyRule)* ;  
allowRule : ALLOW expression NEWLINE ;  // Allow a specific condition
denyRule : DENY expression NEWLINE ;  // Deny a specific condition

// CRYPTOGRAPHY STATEMENT
/* Supports cryptographic functions like encryption, decryption, signing, and verification. */
cryptoStatement : ( encryptStatement | decryptStatement | signStatement | verifyStatement | hashStatement ) ;  
encryptStatement : ENCRYPT L_PAREN expression COMMA expression R_PAREN NEWLINE ;  // Encrypt data
decryptStatement : DECRYPT L_PAREN expression COMMA expression R_PAREN NEWLINE ;  // Decrypt data
signStatement : SIGN L_PAREN expression COMMA expression R_PAREN NEWLINE ;  // Sign data
verifyStatement : VERIFY L_PAREN expression COMMA expression R_PAREN NEWLINE ;  // Verify signature
hashStatement : HASH L_PAREN expression R_PAREN NEWLINE ;  // Generate hash

// SYSTEM ENVIRONMENT STATEMENT  
/* Retrieves system-specific information, such as OS or hostname. */
sysenvStatement : SYSENV L_PAREN expression R_PAREN NEWLINE ;  

// COMMENTS
/* Comments are ignored by the parser and used for documentation. */
comment : HASH_COMMENT | COMMENT_BLOCK ;  

// EXPRESSIONS
/* Expressions are the building blocks of the configuration, used for calculations or evaluations. */
expression : primaryExpression (operator primaryExpression)* ;  

// MATH OPERATORS & CONVERSION OPERATOR
operator : PLUS | MINUS | STAR | DIV | TO ;  // Basic operators and unit conversion

// PRIMARY EXPRESSIONS
primaryExpression : literal | functionCall | variable | lambdaExpr | '(' expression ')' | list | dictionary ;  

// Lambda-like expression
lambdaExpr : PIPE paramList PIPE expression ;  // Anonymous function definition

// List (Array) with Optional Comprehension
list : LA_BRACKET (expression (COMMA expression)*)? (FOR ID IN expression (IF expression)?)? RA_BRACKET ;  // List with optional comprehension

// Dictionary
dictionary : LC_BRACE (keyValuePair (COMMA keyValuePair)*)? RC_BRACE ;  // Key-value pairs for configuration

keyValuePair : ID COLON expression ;  // A single key-value pair

// TYPES
type : 'int' | 'float' | 'bool' | 'string' | 'dimension' ;  // Supported types for variables

// LITERALS AND VARIABLES
literal : STRING | NUMBER | BOOLEAN | ASSET_PATTERN ;  // Types of literals
variable : ID ;  // A variable identifier

// ATTRIBUTE (for resource references)
attribute : ID EQUAL expression ;  // Key-value pair for resource attributes
