%{
    #include <stdio.h>
    #include "y.tab.h"
%}

%%

[a-zA-Z0-9]+  { yylval.str = strdup(yytext); return STR; }  
[ \t\n]       { /* Ignore whitespace */ }

%%

int yywrap() {
    return 1;
}
