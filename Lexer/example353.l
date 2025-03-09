%{
#include <stdio.h>
%}

%%

float    { printf("double"); }  /* Replace float with double */
.|\n     { putchar(yytext[0]); } /* Copy everything else unchanged */

%%

int main() {
    yylex();  // Start scanning input
    return 0;
}

int yywrap() {
    return 1;
}

