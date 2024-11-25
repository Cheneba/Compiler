#include "token.h"
#include <stdio.h>

extern FILE *yyin;
extern int yylex();
extern char *yytext;

int main() {
    yyin = fopen("program.c","r");
    if(!yyin) 
    {
        printf("could not open program.c!\n");
        return 1;
    }
    while(1) 
    {
        token_t t = yylex();
        if(t==TOKEN_EOF) break;
        else if(t==TOKEN_UNCOMPLETED_MULTI_LINE_COMMENT) {
            printf("Uncompleted multi-line comment found. Exiting...");
            break;
        }
        printf("token_type: %d text: %s\n",t,yytext);
    }
}