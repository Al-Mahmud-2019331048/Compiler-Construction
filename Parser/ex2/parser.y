%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

#define MAX_LENGTH 1024  // Buffer for flattened output
char output[MAX_LENGTH]; // Stores the final result
void append(const char* str);
%}

/* ✅ Define YYSTYPE to handle strings */
%union {
    char* str;
}

/* ✅ Define Tokens with Types */
%token <str> CHAR  
%type <str> S L  // Declare Nonterminals as Strings
%left ';' // Semicolon separates elements in a list

%%

/* ✅ Grammar Rules */
S   : '(' L ')'   { $$ = strdup($2); append($$); }  // Nested list
    | CHAR        { $$ = strdup($1); append($$); }  // Single character
    ;

L   : L ';' S     { 
                      char *temp = malloc(strlen($1) + strlen($3) + 2);
                      sprintf(temp, "%s %s", $1, $3);
                      $$ = temp;
                  } // Multiple elements
    | S           { $$ = strdup($1); }  // Single element
    ;

%%

/* ✅ Function to append elements to the output buffer */
void append(const char* str) {
    if (strlen(output) + strlen(str) < MAX_LENGTH) {
        strcat(output, str);
    }
}

/* ✅ Error Handling Function */
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

/* ✅ Main Function */
int main() {
    printf("Enter a nested list:\n");
    output[0] = '\0';  // Initialize output buffer
    yyparse();
    printf("Flattened list: %s\n", output);
    return 0;
}
