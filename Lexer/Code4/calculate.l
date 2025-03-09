%{
    #include "calculate.tab.h"
    #include <stdlib.h>
%}


%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t\n]+    {}
"+"         { return PLUS; }
"-"         { return MINUS; }
.           {}
%%

int yywrap()
{
    return 1;
}
