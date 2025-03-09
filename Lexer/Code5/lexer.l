%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Token Definitions */
#define LT 1
#define LE 2
#define EQ 3
#define NE 4
#define GT 5
#define GE 6
#define IF 7
#define THEN 8
#define ELSE 9
#define WHILE 13  /* Added WHILE keyword */
#define ID 10
#define NUMBER 11
#define RELOP 12
#define STRING 14  /* Added STRING token */

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
/* Rules – Pattern { Action } pairs */ 

[ \t\n]+     {/* Ignore whitespace */}  

if      { printf("Keyword: IF\n"); return IF; }
then    { printf("Keyword: THEN\n"); return THEN; }
else    { printf("Keyword: ELSE\n"); return ELSE; }
while   { printf("Keyword: WHILE\n"); return WHILE; }  /* Added WHILE */

[A-Za-z_][A-Za-z0-9_]*   { printf("Identifier: %s\n", yytext); return installID(); }  /* Allows underscore */

[0-9]+(\.[0-9]+)?(E[+-]?[0-9]+)?  { printf("Number: %s\n", yytext); return installNum(); }

"<"     { printf("Relational Operator: <\n"); yylval.num = LT; return RELOP; }
"<="    { printf("Relational Operator: <=\n"); yylval.num = LE; return RELOP; }
"=="    { printf("Relational Operator: ==\n"); yylval.num = EQ; return RELOP; }  /* Changed '=' to '==' */
"!="    { printf("Relational Operator: !=\n"); yylval.num = NE; return RELOP; }  /* Changed '<>' to '!=' */
">"     { printf("Relational Operator: >\n"); yylval.num = GT; return RELOP; }
">="    { printf("Relational Operator: >=\n"); yylval.num = GE; return RELOP; }

\"(\\.|[^"\\])*\"  {  /* String Handling */
    char *str = strdup(yytext + 1);  // Remove first quote
    str[strlen(str) - 1] = '\0';  // Remove last quote
    printf("String: %s\n", str); 
    return STRING;
}

.       { printf("Unknown character: %s\n", yytext); }

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

/* Main function */
int main() {
    while (yylex()) // Continue processing tokens until EOF
        ;
    return 0;
}

/* Function required by Lex to handle end-of-input */
int yywrap() {
    return 1;
}
