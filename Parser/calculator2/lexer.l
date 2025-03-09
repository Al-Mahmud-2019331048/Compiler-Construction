%{
#include "y.tab.h"  // ✅ Include Yacc-generated token definitions
#include <stdio.h>
%}

%%

"true"   { return TRUE; }
"false"  { return FALSE; }
"&&"     { return AND; }  // ✅ Return integer token AND
"||"     { return OR; }   // ✅ Return integer token OR
"!"      { return '!'; }  // ✅ NOT operator
"("      { return '('; }
")"      { return ')'; }
[ \t\n]  { /* Ignore whitespace */ }
.        { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
