# Wryneck

A dynamic configuration extension file format with interpreter.

As expected, Wryneck functions as a configuration file format but also offers lightweight scripting capabilities robust enough for certain game development applications.

## Motivation Behind the Project

That is simple: One of my dream video game I wish to make inspired this development.

Given the wide adoption of better data interchange formats out there, it is intended for my use. Nonetheless, having started a primitive version back in the early March of 2025, I have been manually writing a language translator for parsing my custom configuration file via recursive descent parsing strategy. 

An intermediate software that hot reloads the program based on dynamic data was required back then. Not long after that, the partial write up of its earliest version was too tedious to work with, so I opted for another solution.

Only when I had relevant specialized tooling and reference works—available in [the ANTLR v4](https://www.antlr.org/) and [the LLVM compiler infrastructure](https://llvm.org/) websites—at my disposal did I finally revise the formal specification of its context-free grammar. My code being open source, you can see tokens and syntactic rules divided into two grammar files, respectively the lexer and parser files. 

You may study them as you please. They currently amount to ~200 LoC in total, but will grow in number quite soon.
