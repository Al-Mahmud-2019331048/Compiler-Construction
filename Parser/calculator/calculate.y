%{
    #include <stdio.h>
    #include <stdlib.h>

// Declare lexer function and error function
    int yylex();
    void yyerror(const char *s);
%}

%token NUMBER PLUS MINUS MUL DIV

%%
program    : expression '\n' { printf("Result: %d\n", $1); }
          | error '\n' { yyerror("Invalid expression!"); yyclearin; yyerrok; }
          ;

expression : expression PLUS NUMBER  { $$ = $1 + $3; }
          | expression MINUS NUMBER { $$ = $1 - $3; }
          | expression MUL NUMBER {$$ = $1 * $3; }
          | expression DIV NUMBER {$$ = $1 / $3; }
          | NUMBER                   { $$ = $1; }
          ;

%%

int main()
{
    printf("Enter your expression:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s)
{
    printf("Error: %s\n", s);
}
