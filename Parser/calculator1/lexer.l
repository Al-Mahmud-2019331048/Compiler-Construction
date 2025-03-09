%{
#include "y.tab.h"   // Include Yacc token definitions
#include <stdlib.h>
%}

%%

[0-9]+      { yylval = atoi(yytext); return DIGIT; }  // Convert digit to integer
[+\-*()/]    { return yytext[0]; }  // Return operators as tokens
\n          { return '\n'; }  // Return newline to trigger evaluation
[ \t]       { /* Ignore whitespace */ }  // Ignore spaces and tabs
.           { printf("Invalid character: %s\n", yytext); }  // Handle invalid input

%%

int yywrap() {
    return 1;
}
