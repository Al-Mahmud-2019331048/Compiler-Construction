##To run lexer and parser combinedly

yacc -d parser.y

lex lexer.l

gcc -o parser y.tab.c lex.yy.c -ll

./parser
