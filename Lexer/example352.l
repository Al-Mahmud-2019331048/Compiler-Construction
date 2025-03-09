%{
#include <stdio.h>
%}

%%

[ \t\n\r]+    { printf(" "); }  /* Replace any sequence of whitespace with a single space */
.             { printf("%s", yytext); } /* Print all other characters as they are */

%%

int main() {
    yylex();  // Start lexical analysis
    return 0;
}

int yywrap() {
    return 1;
}

