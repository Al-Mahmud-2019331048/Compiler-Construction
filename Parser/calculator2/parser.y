%{
#include <stdio.h>
#include <stdlib.h>

//#define YYSTYPE double  // Ensures all values are treated as double

int yylex();
void yyerror(const char *s);
%}

// Define precedence and associativity
%left '+' '-'
%left '*' '/'
%right UMINUS

%token NUMBER

%%
lines   : lines expr '\n' { printf("Result: %d\n", $2); }  
        | lines '\n'  // Allows blank lines
        | /* empty */ // Allows starting with a blank line
        ;

expr    : expr '+' expr { $$ = $1 + $3; }
        | expr '-' expr { $$ = $1 - $3; }
        | expr '*' expr { $$ = $1 * $3; }
        | expr '/' expr { 
            if ($3 == 0) {
                yyerror("Division by zero");
                $$ = 0;
            } else {
                $$ = $1 / $3;
            }
        }
        | '(' expr ')'  { $$ = $2; }
        | '-' expr %prec UMINUS { $$ = -$2; }  // Unary minus
        | NUMBER        { $$ = $1; }  // Correctly store NUMBER
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
