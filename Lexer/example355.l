%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

/* Function to convert text to lowercase */
void to_lowercase(char *str) {
    for (int i = 0; str[i]; i++)
        str[i] = tolower(str[i]);
}
%}

/* Regular Expressions */
ws      [ \t\n]+
letter  [A-Za-z]
digit   [0-9]
id      {letter}({letter}|{digit})*

%%

[sS][eE][lL][eE][cC][tT] { printf("TOKEN: SELECT\n"); }
[fF][rR][oO][mM]         { printf("TOKEN: FROM\n"); }
[wW][hH][eE][rR][eE]     { printf("TOKEN: WHERE\n"); }
{id}                     { printf("TOKEN: ID (%s)\n", yytext); }
{ws}                     { /* Ignore whitespace */ }

.                        { printf("TOKEN: UNKNOWN (%s)\n", yytext); }

%%

int main() {
    printf("Enter SQL query: ");
    yylex();  // Start Lexical Analysis
    return 0;
}

int yywrap() {
    return 1;
}

