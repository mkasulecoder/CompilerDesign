// CMSC 430 Compiler Theory and Design
// Project 1 Skeleton
// UMGC CITE
// Summer 2023

// This file contains the bodies of the functions that produces the 
// compilation listing

#include <cstdio>
#include <string>
#include <queue>

using namespace std;

#include "listing.h"

static int lineNumber;
static queue<string> errorQueue; // Queue to store error messages for the current line
static int totalErrors = 0;
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int generalSemanticErrors = 0;
static int duplicateIdentifierErrors = 0;
static int undeclaredErrors = 0;

static void displayErrors();

void firstLine()
{
    lineNumber = 1;
    printf("\n%4d  ", lineNumber);
}

void nextLine()
{
    displayErrors();
    lineNumber++;
    printf("%4d  ", lineNumber);
}

int lastLine()
{
    printf("\r");
    displayErrors();

    if (totalErrors > 0) {
		printf("Total errors: %d (Lexical: %d, Syntax: %d, General Semantic: %d, Duplicate Identifier: %d, Undeclared: %d)\n", 
               totalErrors, lexicalErrors, syntaxErrors, generalSemanticErrors, duplicateIdentifierErrors, undeclaredErrors);
	} else {
        printf("Compiled Successfully\n");
    }

    // Clear error counts and the error queue for the next line
    totalErrors = 0;
    lexicalErrors = 0;
    syntaxErrors = 0;
    generalSemanticErrors = 0;
    duplicateIdentifierErrors = 0;
    undeclaredErrors = 0;
    while (!errorQueue.empty()) {
        errorQueue.pop();
    }

    return totalErrors;
}

void appendError(ErrorCategories errorCategory, string message)
{
    string errorMessage;

    switch (errorCategory) {
        case LEXICAL:
            errorMessage = "Lexical Error, Invalid Character " + message;
            lexicalErrors++;
            break;
        case SYNTAX:
            errorMessage = "Syntax Error: " + message;
            syntaxErrors++;
            break;
        case GENERAL_SEMANTIC:
            errorMessage = "General Semantic Error: " + message;
            generalSemanticErrors++;
            break;
        case DUPLICATE_IDENTIFIER:
            errorMessage = "Duplicate Identifier Error: " + message;
            duplicateIdentifierErrors++;
            break;
        case UNDECLARED:
            errorMessage = "Undeclared Identifier Error: " + message;
            undeclaredErrors++;
            break;
        default:
            errorMessage = "Unknown Error: " + message;
            break;
    }

    errorQueue.push(errorMessage); // Add error message to the queue
    totalErrors++; // Increment total error count
}

void displayErrors()
{
    while (!errorQueue.empty()) {
        printf("%s\n", errorQueue.front().c_str());
        errorQueue.pop();
    }
}
