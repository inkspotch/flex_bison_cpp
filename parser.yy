%require "3.0.4"
%debug
%skeleton "lalr1.cc"
%defines
%locations
%define api.namespace { Calculator }
%define parser_class_name { Parser }
%define api.token.constructor
%define api.value.type variant

%code requires {
  namespace Calculator {
    class Lexer;
  }

  class Expression;
}

%parse-param { Lexer &lexer }

%code {
  #include <iostream>
  #include "calculator_lexer.hh"
  #include "expression.hh"

  #undef yylex
  #define yylex lexer.lex
}


%token <int> INTEGER
%token <std::string> IDENTIFIER

%token PLUS
%token END 0

%type <Expression*> expression

%start program

%%

program: /* empty */
       | program expression { std::cout << $2->value() << std::endl; }
       | program IDENTIFIER { std::cout << "program id" << std::endl; }
       ;

expression: INTEGER PLUS INTEGER { $$ = new BinaryOpExpression($1, $3); }

%%

void Calculator::Parser::error(const location_type &l, const std::string &m) {
  std::cerr << "Error: " << m << "\n";
}
