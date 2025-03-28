# Magpie

A dynamic configuration file format with interpreter for the upcoming future.

As expected, Magpie should function as a configuration file format but also will offer lightweight scripting capabilities robust enough for certain game development applications.

## Motivation Behind the Project

That is simple: the dream video game that I wish to create inspired this development. An intermediate software that hot reloads the program based on dynamic data is required.

Given the wide adoption of better data interchange formats out there, it is intended for my use. Nonetheless, having started a primitive version back in the early March of 2025, I have been manually writing a language translator for parsing my custom configuration file. And not long after that thought, the partial write up of its earliest version unfortunately was too tedious to handle, so I opted for another solution.

Only when I had relevant specialized tooling and reference works—available in [the ANTLR v4](https://www.antlr.org/) and [the LLVM compiler infrastructure](https://llvm.org/) websites—at my disposal did I finally revise the formal specification of its context-free grammar. My code being open source, you can see tokens and syntactic rules divided into two grammar files, respectively the lexer and parser files. 

You may study them as you please. Its current state being unusable is to be expected. They currently amount to ~200 LoC in total, but they will grow in number quite soon.
