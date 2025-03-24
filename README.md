# Wryneck

A dynamic configuration extension file format with interpreter.

As expected of configuration file formats, it works as one, while also having a half-fledged scripting capabilities robust enough for some use cases in the game development industry. Its dynamic nature also differentiates it from many others.

## Motivation Behind the Project

That is simple: the requirements of my video game, “One With You,” necessitated this development.

Given the wide adoption of better data interchange formats out there, it was intend for my use. Nonetheless, having started a primitive version back in the early March of 2025, I have been manually writing a language translator for parsing my custom configuration extension file format via recursive descent parsing strategy. Indeed, an intermediate software that hot reloads the program based on dynamic data was required back then. Not long after that, the partial write up of its earliest version was too tedious to work with, so I opted looking for another solution.

Only when I had relevant specialized tooling and reference works—available in [the ANTLR v4](https://www.antlr.org/) and [the LLVM compiler infrastructure](https://llvm.org/) websites—at my disposal did I finally revise the formal specification of its context-free grammar. My code being open source, you can see tokens and syntactic rules divided into two grammar files, respectively the lexer and parser files. You may study them as you please. They currently amount to ~200 LoC in total, but will grow in number quite soon.

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
