%{
    #include <stdio.h>    
%}

%token NUMBER PLUS MINUS

%%
program    : expression             { printf("%d", $1); }

expression : expression PLUS NUMBER  { $$ = $1 + $3; }
expression : expression MINUS NUMBER  { $$ = $1 - $3; }
expression : NUMBER                 { $$ = $1; }

%%

int main()
{
    printf("Enter your expression: \n");
    yyparse();
}

void yyerror(const char *s)
{
    printf("Error %s", s);
}