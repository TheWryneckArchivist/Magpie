# Wryneck

A dynamic configuration extension file format with interpreter.

These files are small, only amounting to ~200 LoC!

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

## Motivation: Why Create It In the First Place?

That's simple: the requirements of my video game, One With You, has made such a task necessary. 

Having started a cruder version back in early March of 2025, I have been writing a language translator by hand for parsing my custom configuration extension file format, *.wry. An intermediate software that hot reloads the program based on dynamic data was required. Not long after that, the partial write up of its earlier version was too tedious to work with.

Only until having relevant specialized tooling and reference works—available in [the ANTLR v4 website](https://www.antlr.org/)— at my disposal did I finally revise the formal specification of its context-free grammar. As there already are wide adoption of better data interchange formats out there, I only expect to use it for my purposes. 

## Learn Through Examples

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
