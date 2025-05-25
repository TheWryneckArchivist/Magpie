parser grammar MagpieParser;  
options { tokenVocab=MagpieLexer; }  

// Root rule
/* The entry point for parsing the configuration file. This will parse multiple statements until the end of the file. */
file : statement* EOF ;  

// Statement
/* A statement can be any one of the various configuration elements, such as constants, imports, or conditionals. */
statement : versionField | importStatement | constant | assignment | computedProperty | macro | resourceReference | versionControlStatement | conditional | metadata | infixDefinition | includeStatement | comment ;  

// Version field
/* Defines the version of the configuration file using the 'version' keyword. */
versionField : VERSION_KEY EQUAL versionLiteral NEWLINE ;  
versionLiteral : VERSION_LITERAL ;  // The version number format

// Import statement
/* Handles importing external configuration files or modules, optionally with conditions and aliases. */
importStatement : IMPORT LA_BRACKET (configFileAlias (COMMA configFileAlias)*)? RA_BRACKET (IF L_PAREN expression R_PAREN)? NEWLINE ;  
configFileAlias : configFile (AS ID)? ;  
configFile : ID | STRING ;  // Can be a file ID or a string representing a file path

// Constant
/* Defines constants that cannot be changed once set. */
constant : CONST ID EQUAL expression NEWLINE ;  

// Assignment
/* Used to assign values to variables or configuration properties, with optional type annotations. */
assignment : metadata* ID (COLON type)? EQUAL expression NEWLINE ;  

// Computed properties
/* Defines properties that are calculated dynamically based on other values. */
computedProperty : metadata* ID EQUAL ARROW expression NEWLINE ;  

// Macro
/* Defines reusable blocks of configuration that can be parameterized and inherited. */
macro : metadata* MACRO ID L_PAREN paramList? R_PAREN (EXTENDS ID)? LC_BRACE macroBody RC_BRACE ;  
paramList : param (COMMA param)* (COMMA ELLIPSIS ID)? ;  // Parameter list with support for variadic parameters
param : ID (EQUAL expression)? ;  // Parameters with optional default values
macroBody : statement* ;  // Body of the macro, which can contain multiple statements

// Resource reference
/* Links external resources such as files, assets, or other configurations. */
resourceReference : metadata* RESOURCE ID EQUAL STRING (attribute)* NEWLINE ;  

// Version control statement
/* Specifies the version status of the configuration (e.g., stable, experimental). */
versionControlStatement : versionControlType ID (attribute)* NEWLINE ;  
versionControlType : STABLE | DEPRECATED | EXPERIMENTAL ;  

// Conditional block
/* Defines if-else blocks to adapt the configuration based on conditions. */
conditional : IF L_PAREN expression R_PAREN LC_BRACE statement* RC_BRACE (ELSE LC_BRACE statement* RC_BRACE)? ;  

// Annotated metadata
/* Metadata annotations for categorizing or tagging configuration properties. */
metadata : METADATA_START ID (COMMA ID)* METADATA_END NEWLINE ;  

// Infix definition (custom operators)
/* Allows the definition of custom operators (e.g., for arithmetic or logic). */
infixDefinition : INFIX ID L_PAREN paramList? R_PAREN ARROW expression NEWLINE ;

// File inclusion statement
/* Handles including external configuration files within the current configuration. */
includeStatement : INCLUDE STRING NEWLINE ;  

// Comment
/* Comments are ignored by the parser and used for documentation. */
comment : HASH_COMMENT | COMMENT_BLOCK ;  

// Expression
/* Expressions are the building blocks of the configuration, used for calculations or evaluations. */
expression : primaryExpression (operator primaryExpression)* ;  

// Arithmetic and conversion operator
operator : PLUS | MINUS | STAR | DIV | TO ;  // Basic operators and unit conversion

// Primary expression
primaryExpression : literal | functionCall | variable | lambdaExpr | '(' expression ')' | list | dictionary ;  

// Lambda-like expression
lambdaExpr : PIPE paramList PIPE expression ;  // Anonymous function definition

// List (array) with optional comprehension
list : LA_BRACKET (expression (COMMA expression)*)? (FOR ID IN expression (IF expression)?)? RA_BRACKET ;  // List with optional comprehension

// dictionary
dictionary : LC_BRACE (keyValuePair (COMMA keyValuePair)*)? RC_BRACE ;  // Key-value pairs for configuration

keyValuePair : ID COLON expression ;  // A single key-value pair

// Built-in types
type : 'int' | 'float' | 'bool' | 'string' | 'dimension' ;  // Supported types for variables

// Literals and variables
literal : STRING | NUMBER | BOOLEAN | ASSET_PATTERN ;  // Types of literals
variable : ID ;  // A variable identifier

// Attribute (for resource references)
attribute : ID EQUAL expression ;  // Key-value pair for resource attributes
