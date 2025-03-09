%{
#include "y.tab.h"
#include <stdio.h>
%}

%%

"true"   { return TRUE; }
"false"  { return FALSE; }
"&&"     { return "&&"; }
"||"     { return "||"; }
"!"      { return '!'; }
"("      { return '('; }
")"      { return ')'; }
[ \t\n]  { /* Ignore whitespace */ }
.        { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
