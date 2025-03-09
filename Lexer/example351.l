%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define MAX_STRINGS 100
char *stringTable[MAX_STRINGS];
int stringCount = 0;

/* Function to process and store strings */
void storeString(const char *str) {
    if (stringCount < MAX_STRINGS) {
        stringTable[stringCount++] = strdup(str);
    }
}
%}

/* Definitions */
delim    [ \t\n\r]
ws       {delim}+
letter   [A-Za-z_]   /* Allow underscore */
digit    [0-9]
id       {letter}({letter}|{digit})*
number   {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
STRING   \"(\\.|[^"\\])*\"  /* String pattern */
%%

{ws}      {/* Ignore whitespace */}
while     { printf("TOKEN: WHILE (%s)\n", yytext); return WHILE; }
"=="      { printf("TOKEN: RELOP EQ (%s)\n", yytext); return EQ; }
"!="      { printf("TOKEN: RELOP NE (%s)\n", yytext); return NE; }
"<"       { printf("TOKEN: RELOP LT (%s)\n", yytext); return LT; }
"<="      { printf("TOKEN: RELOP LE (%s)\n", yytext); return LE; }
">"       { printf("TOKEN: RELOP GT (%s)\n", yytext); return GT; }
">="      { printf("TOKEN: RELOP GE (%s)\n", yytext); return GE; }
{id}      { printf("TOKEN: ID (%s)\n", yytext); return ID; }
{number}  { printf("TOKEN: NUMBER (%s)\n", yytext); return NUMBER; }

{STRING} {
    char processedStr[yyleng];  // Buffer for processed string
    int i, j = 0;
    for (i = 1; i < yyleng - 1; i++) { // Remove surrounding quotes
        if (yytext[i] == '\\' && (yytext[i + 1] == '\\' || yytext[i + 1] == '"')) {
            processedStr[j++] = yytext[++i]; // Handle escape sequences
        } else {
            processedStr[j++] = yytext[i];
        }
    }
    processedStr[j] = '\0';

    printf("TOKEN: STRING (%s)\n", processedStr);
    storeString(processedStr);
    return STRING;
}

.         { printf("TOKEN: UNKNOWN (%s)\n", yytext); }
%%

int main() {
    printf("Enter input: ");
    while (yylex()) {}  // Keep scanning until EOF
    printf("\nLexical analysis completed.\n");

    // Print stored strings
    printf("\nStored Strings:\n");
    for (int i = 0; i < stringCount; i++) {
        printf("%d: %s\n", i, stringTable[i]);
    }

    return 0;
}

int yywrap() {
    return 1;
}

