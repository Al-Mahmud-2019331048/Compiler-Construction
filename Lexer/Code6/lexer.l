%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ID 10
#define NUMBER 11

/* Define yylval manually */
union {
    int num;
    char *id;
} yylval;

/* Function Prototypes */
int installID();
int installNum();
%}

%%

[ \t\n]+    { printf(" \n"); }  /* Replace any whitespace sequence with a single space */
"float"     { printf("double\n"); }  /* Replace 'float' with 'double' */
.           { printf("%s\n", yytext); }  /* Copy all other characters unchanged */
"//".*                 { printf("%s\n", yytext); }    /* Match and print single-line comments */
"/*"([^*]|\*+[^*/])*\*+"/"  { printf("%s\n", yytext); }  /* Match and print multi-line comments */
[A-Za-z][A-Za-z0-9]*   { printf("Identifier: %s\n", yytext); return installID(); }
[0-9]+(\.[0-9]+)?(E[+-]?[0-9]+)?  { printf("Number: %s\n", yytext); return installNum(); }
.      { printf("Unknown: %s\n", yytext); }

%%

/* Function to store identifiers */
int installID() {
    yylval.id = strdup(yytext);
    return ID;
}

/* Function to store numbers */
int installNum() {
    yylval.num = atoi(yytext);
    return NUMBER;
}

int main() {
    while( yylex() );  // Start lexical analysis
    return 0;
}
