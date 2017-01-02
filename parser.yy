%require "3.0.4"
%debug
%skeleton "lalr1.cc"
%defines
%locations
%define api.namespace { Calculator }
%define parser_class_name { Parser }

%code requires {
  namespace Calculator {
    class Lexer;
  }
}

%parse-param { Lexer &lexer }

%code {
  #include <iostream>
  #include "calculator_driver.hh"

  #undef yylex
  #define yylex lexer.yylex
}

%define api.value.type variant

%token <int> INTEGER
%token <std::string> IDENTIFIER

%start program

%%

program: /* empty */
       | program INTEGER { std::cout << "program integer" << std::endl; }
       | program IDENTIFIER { std::cout << "program id" << std::endl; }
       ;

%%

void Calculator::Parser::error(const location_type &l, const std::string &m) {
  std::cerr << "Error: " << m << "\n";
}
