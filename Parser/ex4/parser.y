%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_STATES 100 // Max number of states in the NFA
#define MAX_TRANS 100  // Max number of transitions

int yylex();
void yyerror(const char *s);

typedef struct {
    int from;
    char symbol;
    int to;
} Transition;

Transition transitions[MAX_TRANS]; // Transition table
int state = 0; // Current state counter
int transition_count = 0;

void add_transition(int from, char symbol, int to);
void print_transitions();
%}

/* ✅ Define Tokens */
%token CHAR
%left '+'
%left CONCAT
%right '*'

%%

/* ✅ Regular Expression Grammar */
S   : S '+' S     { 
                     add_transition(state, 'ε', $1); 
                     add_transition(state, 'ε', $3); 
                     $$ = state++; 
                  }
    | S S         { 
                     add_transition($1, 'ε', $2); 
                     $$ = $1; 
                  }
    | '(' S ')'   { $$ = $2; }
    | S '*'       { 
                     add_transition(state, 'ε', $1); 
                     add_transition($1, 'ε', state); 
                     $$ = state++; 
                  }
    | CHAR        { 
                     add_transition(state, $1, state + 1); 
                     $$ = state; 
                     state += 2;
                  }
    ;

%%

/* ✅ Function to Add Transitions */
void add_transition(int from, char symbol, int to) {
    if (transition_count < MAX_TRANS) {
        transitions[transition_count].from = from;
        transitions[transition_count].symbol = symbol;
        transitions[transition_count].to = to;
        transition_count++;
    }
}

/* ✅ Function to Print Transition Table */
void print_transitions() {
    printf("\nTransition Table (NFA):\n");
    printf("-----------------------\n");
    printf("From  | Symbol | To\n");
    printf("-----------------------\n");

    for (int i = 0; i < transition_count; i++) {
        printf("%4d  |   %c    | %4d\n", transitions[i].from, 
               transitions[i].symbol == 'ε' ? 'ε' : transitions[i].symbol, 
               transitions[i].to);
    }
}

/* ✅ Error Handling Function */
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

/* ✅ Main Function */
int main() {
    printf("Enter a Regular Expression:\n");
    yyparse();
    print_transitions();
    return 0;
}
