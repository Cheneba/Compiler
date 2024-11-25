%{
#include "token.h"
#include <stdio.h>
%}

DIGIT [+-]?([0-9]{1,12}(\.[0-9]{1,12})?|(\.[0-9]{1,12}))
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]{0,31}

%%
(" "|\t|\n) /* skip whitespace */

"+"              { return TOKEN_ADD; }  /* OPERATORS HERE */ 
"-"              { return TOKEN_SUB; } 
"*"              { return TOKEN_MULT; } 
"/"              { return TOKEN_DIVIDE; } 
"%"              { return TOKEN_MOD; } 

"="              { return TOKEN_EQUALS; } 
"=="              { return TOKEN_IF_EQUALS; } 
">="              { return TOKEN_IF_GREATER_OR_EQUALS; } 
">"              { return TOKEN_IF_GREATER; } 
"<="              { return TOKEN_IF_LESSER_OR_EQUALS; } 
"<"              { return TOKEN_IF_LESSER; } 

"&&"              { return TOKEN_LOGICAL_AND; } 
"||"              { return TOKEN_LOGICAL_OR; } 


"int"              { return TOKEN_KEYWORD_INT; }    /* KEYWORDS HERE */
"long"              { return TOKEN_KEYWORD_LONG; }
"float"              { return TOKEN_KEYWORD_FLOAT; }
"double"              { return TOKEN_KEYWORD_DOUBLE; }
"short"              { return TOKEN_KEYWORD_SHORT; }
"bool"              { return TOKEN_KEYWORD_BOOL; }
"for"              { return TOKEN_KEYWORD_FOR; }
"if"              { return TOKEN_KEYWORD_IF; }
"else"              { return TOKEN_KEYWORD_ELSE; }
"return"              { return TOKEN_KEYWORD_RETURN; }
"break"              { return TOKEN_KEYWORD_BREAK; }
"do"              { return TOKEN_KEYWORD_DO; }
"while"           { return TOKEN_KEYWORD_WHILE; }
"true"           { return TOKEN_KEYWORD_TRUE; }
"false"           { return TOKEN_KEYWORD_FALSE; }



{IDENTIFIER}  { return TOKEN_IDENT; }  /* IDENTIFIERS HERE */

"//".*             ; /* Ignore single-line comments */
"/*"([^*]|\*+[^*/])*\*+"/"  ; /* Ignore complete multi-line comments */
"/*"([^*]|\*+[^*/])*$       { printf("Found unclosed multi-line comment: Line %d\n", yylineno); return TOKEN_UNCOMPLETED_MULTI_LINE_COMMENT; }


\"(\\.|[^"\\])*\"  { return TOKEN_STRING; }  /* STRING LITERALS HERE */

"#".*          { printf("Line: %d\n",yylineno); }/* preprocessors skip here : try and understand how to link the input code line to here or something*/

{DIGIT}+        { return TOKEN_NUMBER; }  /* NUMBERS(+VE/-VE) here */


";"     { return TOKEN_EOL; } /* END OF LINE (SEMI-COLON) */
.   
%%
int yywrap() { return 1; }