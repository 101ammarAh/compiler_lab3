# compiler_lab3

lex lexer.l
gcc -o parser y.tab.c lex.yy.c -ll
./parser [input file]
