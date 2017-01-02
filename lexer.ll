%{

  #include "calculator_lexer.hh"
  #undef YY_DECL
  #define YY_DECL int Calculator::Lexer::yylex( \
      Calculator::Parser::semantic_type* const lval, \
      Calculator::Parser::location_type* loc)

  using token = Calculator::Parser::token;

%}

%option c++
%option debug
%option yyclass="Calculator::Lexer"
%option noyywrap

DIGIT [0-9]
ALPHA [A-Za-z]

%%

{DIGIT}+ { return token::INTEGER; }

{ALPHA}({DIGIT}|{ALPHA})* { return token::IDENTIFIER; }

[ \t\n] { /* ignore whitespace */ }

