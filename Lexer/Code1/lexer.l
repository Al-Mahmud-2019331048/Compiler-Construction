%{
#include <stdio.h>  // Include standard I/O functions
%}

%%

http:\/\/                  { printf("PROTOCOL "); }  /* Match protocol (http://) */
www\.[a-zA-Z0-9]+\.com     { printf("DOMAIN(%s) ", yytext); }  /* Match domain (e.g., www.example.com) */
\/[a-zA-Z0-9]+             { printf("PATH(%s) ", yytext); }  /* Match path (e.g., /home) */
\?                         { printf("QUERY_START "); }  /* Match start of query parameters */
[a-zA-Z0-9]+=              { yytext[yyleng-1] = '\0'; 
                                printf("PARAM(%s) ", yytext); }  /* Match query key (e.g., id=) */
[a-zA-Z0-9]+(&|$)          { if(yytext[yyleng-1] == '&') 
                                yytext[yyleng-1] = '\0'; printf("VALUE(%s) ", yytext); }  /* Match query value (e.g., 100) */
&                          { printf("AND "); }  /* Match '&' between query params */
[ \t\n]                    { /* Ignore whitespace */ }  
.                          { printf("UNKNOWN(%s) ", yytext); }  /* Catch unknown characters */

%%

int main() { 
    yylex();   /* Start lexical analysis */
    return 0; 
} 
