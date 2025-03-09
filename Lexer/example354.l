%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

/* Function to check if a character is a vowel */
int is_vowel(char ch) {
    ch = tolower(ch);
    return (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u');
}
%}

/* Regular expressions */
word   [A-Za-z]+
whitespace  [ \t\n]
punctuation [^A-Za-z \t\n]

%%

{word}   {
    char modified[100]; // Buffer for transformed word
    if (is_vowel(yytext[0])) {
        sprintf(modified, "%say", yytext); // Add "ay" if word starts with a vowel
    } else {
        sprintf(modified, "%s%cay", yytext+1, yytext[0]); // Move first consonant to the end and add "ay"
    }
    printf("%s", modified);
}

{whitespace}  { printf("%s", yytext); }  /* Preserve whitespace */
{punctuation} { printf("%s", yytext); }  /* Preserve punctuation */

%%

int main() {
    yylex();  // Start scanning input
    return 0;
}

int yywrap() {
    return 1;
}

