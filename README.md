# Magpie

A dynamic configuration file format with interpreter for the upcoming future.

As expected, Magpie should function as a configuration file format but also will offer lightweight scripting capabilities robust enough for certain game development applications.

## Motivation Behind the Project

If you ever wonder what started all this, I might just tell any reader here that the dream video game  I wish to create inspired this development—an intermediate software that hot reloads the program based on dynamic data is required for that program, and thus the project was born.

Given the wide adoption of better data interchange formats out there, it is intended for my use. I have been manually writing a language translator for parsing my custom configuration file, having started the partial write up of its earliest version back in the early March of 2025. Unfortunately, it was too tedious to handle, so I opted for another solution.

Only when I had relevant specialized tooling and reference works—which are available in [the ANTLR v4](https://www.antlr.org/) and [the LLVM compiler infrastructure](https://llvm.org/) websites—at my disposal did I finally revise the formal specification of its context-free grammar. My code being open source, you can see tokens and syntactic rules divided into two grammar files, respectively the lexer and parser files. 

You may study them as you please. Its current state being unusable is to be expected. They currently amount to ~200 LoC in total, but they will grow in number quite soon.
