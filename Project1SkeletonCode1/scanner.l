/* CMSC 430 Compiler Theory and Design
   Project 1 Skeleton
   UMGC CITE
   Summer 2024 
   Mark Kasule
   Date 06/24/2024
*/
/* Compiler Theory and Design */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

extern int yylval; // Defined in tokens.h if needed

%}

%option noyywrap

ws		[ \t\r]+
comment		("//".*\n)|("--".*\n)
line		[\n]
id          [A-Za-z]([A-Za-z0-9]|_[A-Za-z0-9]|__[A-Za-z0-9])*[A-Za-z0-9]
digit		[0-9]
dec			{digit}+
hex       	[#][0-9A-Fa-f]+
real      	[0-9]*\.[0-9]+([Ee][+-]?[0-9]+)?
char      	'([^\\']|\\[btnrf\\'])'
punc		[\(\),:;]


%%


{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine(); }
{line}		{ ECHO; nextLine(); }
"+"		{ ECHO; return(ADDOP); }
"-"		{ ECHO; return(ADDOP); }
"*"		{ ECHO; return(MULOP); }
"/"		{ ECHO; return(MULOP); }
"&"		{ ECHO; return(ANDOP); }
"<"		{ ECHO; return(RELOP); }
"=>"	{ ECHO; return(ARROW); }
"|"		{ ECHO; return(OROP); }
"!"		{ ECHO; return(NOTOP); }
"="		{ ECHO; return(RELOP); }
"<>"	{ ECHO; return(RELOP); }
">"		{ ECHO; return(RELOP); }
">="	{ ECHO; return(RELOP); }
"<="	{ ECHO; return(RELOP); }
"%"		{ ECHO; return(REMOP); }
"^"		{ ECHO; return(EXPOP); }
"~"		{ ECHO; return(NEGOP); }
begin		{ ECHO; return(BEGIN_); }
case		{ ECHO; return(CASE); }
character	{ ECHO; return(CHARACTER); }
end		{ ECHO; return(END); }
endswitch	{ ECHO; return(ENDSWITCH); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
list		{ ECHO; return(LIST); }
of		{ ECHO; return(OF); }
others		{ ECHO; return(OTHERS); }
returns		{ ECHO; return(RETURNS); }
switch		{ ECHO; return(SWITCH); }
when		{ ECHO; return(WHEN); }
else            { ECHO; return(ELSE); }
elsif           { ECHO; return(ELSEIF); }
endfold         { ECHO; return(ENDFOLD); }
endif           { ECHO; return(ENDIF); }
fold            { ECHO; return(FOLD); }
if              { ECHO; return(IF); }
left            { ECHO; return(LEFT); }
real            { ECHO; return(REAL); }
right           { ECHO; return(RIGHT); }
then            { ECHO; return(THEN); }

{id}		{ ECHO; return(IDENTIFIER);}
{dec}		{ ECHO; return(INT_LITERAL); }
{hex}       { ECHO; return(HEX_LITERAL); }
{real}      { ECHO; return(REAL_LITERAL); }
{char}		{ ECHO; return(CHAR_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }

%%

int main() {
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "wa"); 
	int token = yylex();
	while (token) {
		fprintf(file, "%d %s\n", token, yytext);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}
