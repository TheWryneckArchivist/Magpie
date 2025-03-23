# Wryneck

A dynamic configuration extension file format with interpreter.

## Language Features

* Dynamic Computation & Expression Handling
* Modular & Reusable
* Security
* System Integration
* Advanced Configuration Logic
* Simplicity & Expressiveness
* Extensibility
* Secure and Traceable Configuration
* Flexible Data Types and Serialization

## Motivation Behind the Project

That's simple: the requirements of my video game, 'One With You,' necessitated this development.

Given the wide adoption of better data interchange formats, I intend it for my use. Nonetheless, having started a less refined version back in the early March of 2025, I have been manually writing a language translator for parsing my custom configuration extension file format via recursive descent parsing. It is because an intermediate software that hot reloads the program based on dynamic data is required. Not long after that, the partial write up of its earlier version was too tedious to work with.

Only when I had relevant specialized tooling and reference works—available in [the ANTLR v4](https://www.antlr.org/) and [the LLVM compiler infrastructure](https://llvm.org/) websites—at my disposal did I finally revise the formal specification of its context-free grammar. My code being open source, you can see tokens and syntactic rules divided into two grammar files, respectively the lexer and parser files. They currently amount to ~200 LoC, but these will grow in number quite soon. As expected of static storage configuration file formats, it works as one, while also having a half-fledged scripting capabilities robust enough for some use cases in the game development industry.

## Illustrative Examples

* Dynamic Computation & Expression Handling
  * Computed Properties:

    Values are computed on-demand from other properties.
    ```
    totalCost => basePrice + taxAmount
    ```
  * Custom Infix Operators: define new operators for custom calculations
    ```
    infix power (a, b) => a ** b
    result = 2 power 3  // Evaluates to 8
    ```

* Modular & Reusable;
* Security;
* System Integration;
* Advanced Configuration Logic;
* Simplicity & Expressiveness;
* Extensibility;
* Secure and Traceable Configuration;
* Flexible Data Types and Serialization;



## Download & Installation
