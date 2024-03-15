# compiler_lab3

lex lexer.l <br>
gcc -o parser y.tab.c lex.yy.c -ll <br>
./parser [input file] <br> <br>
Only lex <br>
lex lexer.l
 <br>
gcc -o lexer lex.yy.c -ll <br>
./lexer
<br> <br>

lex with cpp <br>
lex lexer.l <br>
gcc -c -o lex.yy.o lex.yy.c <br>
g++ -o my_program my_program.cpp lex.yy.o -ll <br>
./my_program <br>
