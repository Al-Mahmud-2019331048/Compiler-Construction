%{
    #include "y.tab.h"
    #include <stdlib.h>
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t]       { /* Ignore spaces and tabs */ }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         {return MUL;}
"/"         { return DIV;}
\n          { return '\n'; }  // Ensure newlines are passed to Yacc
.           { printf("Invalid character: %s\n", yytext); }

%%

int yywrap()
{
    return 1;
}
