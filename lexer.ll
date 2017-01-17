%{

  #include "calculator_lexer.hh"
  #undef YY_DECL
/*  #define YY_DECL Calculator::Parser::symbol_type Calculator::Lexer::yylex( \
      Calculator::Parser::semantic_type* const lval, \
      Calculator::Parser::location_type* loc)
*/

#define YY_DECL Calculator::Parser::symbol_type Calculator::Lexer::lex()
  using token = Calculator::Parser::token;

  static Calculator::location l;

  #define yyterminate() Calculator::Parser::make_END(l);
%}

%option c++
%option debug
%option yyclass="Calculator::Lexer"
%option noyywrap

DIGIT [0-9]
ALPHA [A-Za-z]

%%

{DIGIT}+ {  
            int integer = std::atoi(YYText());
            return Calculator::Parser::make_INTEGER(integer, l);
         }

{ALPHA}({DIGIT}|{ALPHA})* { return Calculator::Parser::make_IDENTIFIER(YYText(), l); }

"+" { return Calculator::Parser::make_PLUS(l); }
[ \t\n] { /* ignore whitespace */ }

<<EOF>> { return yyterminate(); }
