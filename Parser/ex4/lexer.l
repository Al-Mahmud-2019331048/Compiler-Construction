%{
#include "y.tab.h"  // Include Yacc header file
#include <stdio.h>
%}

%%

[a-zA-Z0-9] { yylval = yytext[0]; return CHAR; } // Accept single characters
"("         { return '('; }
")"         { return ')'; }
"*"         { return '*'; }
"+"         { return '+'; }
[ \t\n]     { /* Ignore spaces/tabs */ }
.           { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
