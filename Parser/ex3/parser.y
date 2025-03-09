/*
 * YACC Program to Check if a Given String is a Palindrome
 * 
 * This program uses YACC (Yet Another Compiler Compiler) to parse input strings 
 * and determine whether they are palindromes. 
 * The lexical analyzer (Lex) tokenizes the input and passes it to the parser (YACC), 
 * which then checks for palindrome status using a dedicated function.
 */

%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    
    extern int yylex();
    void yyerror(const char *msg);
    void check_palindrome(const char *str);
%}

%union {
    char* str;
}

%token <str> STR
%type <str> E

%%

S : E {
        check_palindrome($1);
    };

E : STR { $$ = $1; };

%%

/* Function to check if a given string is a palindrome */
void check_palindrome(const char *str) {
    int len = strlen(str);
    int is_palindrome = 1;
    
    for (int i = 0; i < len / 2; i++) {
        if (str[i] != str[len - i - 1]) {
            is_palindrome = 0;
            break;
        }
    }
    
    if (is_palindrome) {
        printf("Palindrome\n");
    } else {
        printf("Not palindrome\n");
    }
    
    //printf("Input: %s\n", str);
}

/* Error handler function */
void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
    exit(1);
}

/* Driver function */
int main() {
    printf("Enter a valid string: \n");
    yyparse();
    return 0;
}
