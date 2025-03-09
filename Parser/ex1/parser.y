%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

/* ✅ Define Boolean Tokens */
%token TRUE FALSE
%token AND OR  // ✅ Define AND and OR as integer tokens
%left OR    // OR has lowest precedence
%left AND   // AND has higher precedence than OR
%right '!'  // NOT has highest precedence

%%

/* ✅ Boolean Expression Grammar Using Only `expr` */
expr    : expr OR expr { $$ = $1 || $3; }
        | expr AND expr { $$ = $1 && $3; }
        | '!' expr      { $$ = !$2; }
        | '(' expr ')'  { $$ = $2; }
        | TRUE          { $$ = 1; }
        | FALSE         { $$ = 0; }
        ;

%%

/* ✅ Error Handling Function */
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

/* ✅ Main Function */
int main() {
    printf("Enter a Boolean expression (true, false, &&, ||, !):\n");
    yyparse();
    return 0;
}
