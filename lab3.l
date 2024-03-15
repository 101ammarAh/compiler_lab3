%{
#include <stdio.h>
#include <stdlib.h>
#include "lab3_header.h"
%}

%option noyywrap

%%

[ \t]+               ; /* Ignore whitespaces */
int                  return KEY;
char                 return KEY;
float                return KEY;
[a-zA-Z][a-zA-Z0-9_]* return ID;
[0-9]+               return NUM;      // Updated pattern to match one or more digits
[+*-]                return OP;
[ \t]*=              return ASS_OP;
;                    return EOL;
.                    return yytext[0];
\n                   ; /* Ignore newlines */

%%

int main(int argc, char **argv) {
    // Open a file if provided
    if (argc > 1) {
        FILE *file;
        file = fopen(argv[1], "r");
        if (!file) {
            perror("Error opening file");
            return 1;
        }
        yyin = file;
    }

    // yyin is defined in Lex; it's the input stream (defaults to stdin)
    int token = yylex(); // Start the lexical analysis

    while(token) {
        switch(token) {
            case KEY:
                printf("got key\n");
                token = yylex();
                if(token == ID) {
                    printf("got ID\n");
                    token = yylex();
                    if(token == EOL) {
                        printf("got ;\n");
                        // Valid syntax for declaration
                        token = yylex();
                        continue;
                    } else if (token == ASS_OP) {
                        printf("got =\n");

                        token = yylex();
                        if(token == ID || token == NUM) {
                            printf("got ID || NUM\n");

                            // Valid syntax for assignment
                            token = yylex();
                            while (token != EOL) {
                                if (token == OP && yylex() == EOL) {
                                    printf("invalid syntax: line should not end with an operator\n");
                                    break;
                                }
                                token = yylex();
                            }
                            if (token == EOL) {
                                printf("got ;\n");
                                token = yylex();  // Move to the next line
                                continue;
                            }
                        } else {
                            printf("invalid syntax: expecting ID or NUM\n");
                            break;
                        }
                    } else {
                        printf("invalid syntax: expecting ; or =\n");
                        break;
                    }
                } else {
                    printf("invalid syntax: expecting ID\n");
                    break;
                }
            default:
                printf("invalid syntax: expecting a keyword\n");
                return 0;
                break;
        }
    }

    fclose(yyin);
    printf("SUCCESS!\n");
    return 0;
}
