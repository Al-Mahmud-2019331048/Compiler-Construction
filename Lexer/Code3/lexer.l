%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

/* Function to convert text to lowercase */
void to_lowercase(char *str) {
    for (int i = 0; str[i]; i++)
        str[i] = tolower(str[i]);
}
%}

/* Regular Expressions */
url     (((https?|ftp):\/\/)|www\.)[a-zA-Z0-9._~:/?#\[\]@!$&'()*+,;=%-]+
email   [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}

%%

{url}       { printf("<URL> "); }  
{email}     { printf("<EMAIL> "); }  
[a-zA-Z]+   { to_lowercase(yytext); printf("%s ", yytext); }  
.           { printf("%s", yytext); }  

%%

int main() {
    printf("Enter text: ");
    yylex();  // Start Lexical Analysis
    return 0;
}

int yywrap() {
    return 1;
}