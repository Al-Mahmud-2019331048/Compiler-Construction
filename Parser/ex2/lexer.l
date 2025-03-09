%{
#include "y.tab.h"  // Include Yacc header file
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%

[a-zA-Z0-9] { 
    yylval.str = strdup(yytext); 
    return CHAR; 
} // Store single character as string

"("         { return '('; }
")"         { return ')'; }
";"         { return ';'; }
[ \t\n]     { /* Ignore whitespace */ }
.           { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
