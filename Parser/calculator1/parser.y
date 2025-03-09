%{
#include <stdio.h>
#include <stdlib.h>

// Declare lexer and error functions
int yylex();
void yyerror(const char *s);
%}

%token DIGIT

%%
line  : expr '\n'   { printf("Result: %d\n", $1); }
      ;

expr  : expr '+' term  { $$ = $1 + $3; }
      | expr '-' term  { $$ = $1 - $3; }
      | term           { $$ = $1; }
      ;

term  : term '*' factor { $$ = $1 * $3; }
      | term '/' factor { $$ = $1 / $3; }
      | factor          { $$ = $1; }
      ;

factor: '(' expr ')'  { $$ = $2; }
      | DIGIT         { $$ = $1; }
      ;

%%

// Error handling function
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

// Main function
int main() {
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}
