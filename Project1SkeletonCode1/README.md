Here's a README.md file for GitHub based on the project description:

# Lexical Analyzer and Compilation Listing Generator

This project involves modifying an existing lexical analyzer (`scanner.l`) and compilation listing generator code. The goal is to enhance the lexical analysis capabilities and improve error reporting.

## Modifications to the Lexical Analyzer (scanner.l)

1. Added new reserved words:
   - else, elsif, endfold, endif, fold, if, left, real, right, then
   - Each word is a separate token with the token name in all uppercase

2. New logical operators:
   - `|` (OROP)
   - `!` (NOTOP)

3. New relational operators (all represented by RELOP token):
   - `=`, `<>`, `>`, `>=`, `<=`

4. Additional operators:
   - `-` (subtraction) added to ADDOP
   - `/` (division) added to MULOP
   - `%` (remainder) as new REMOP token
   - `^` (exponentiation) as new EXPOP token
   - `~` (unary minus) as new NEGOP token

5. New comment type:
   - Starts with `--` and ends with the end of line

6. Modified identifier definition:
   - Allows underscores, but no more than two consecutive
   - No leading or trailing underscores

7. New integer literal:
   - Hexadecimal integers starting with `#` followed by digits 0-9 or A-F (case-insensitive)

8. New real literal token:
   - Format: `[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?`

9. Extended character literals:
   - Added escape characters: `\b`, `\t`, `\n`, `\r`, `\f`

## Modifications to tokens.h

- Added new tokens for all the additions mentioned above

## Modifications to Compilation Listing Generator

1. Enhanced `lastLine` function:
   - Computes total number of errors
   - Displays count of lexical, syntactic, and semantic errors if any
   - Displays "Compiled Successfully" if no errors
   - Returns total error count

2. Enhanced `appendError` function:
   - Counts lexical, syntactic, and semantic errors separately
   - Adds error messages to a queue for each line

3. Enhanced `displayErrors` function:
   - Displays all error messages for the previous line
   - Clears the message queue after display

## Example Output

### Successful Compilation:

```
1 // Function with Arithmetic Expression
2
3 function main returns integer;
4 begin
5 7 + 2 * (5 + 4);
6 end;
Compiled Successfully
```

### Compilation with Errors:

```
1 // Function with Two Lexical Errors
2
3 function main returns integer;
4 begin
5 7 $ 2 ? (2 + 4);
Lexical Error, Invalid Character $
Lexical Error, Invalid Character ?
6 end;
Lexical Errors 2
Syntax Errors 0
Semantic Errors 0
```

## Getting Started

[Add instructions on how to set up and run the project]

## Contributing

[Add guidelines for contributing to the project]

## License
[MIT]