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

%token LPAREN RPAREN LBRACE RBRACE
%token DEF 
%token PLUS 
%token END 0 

%type <Expression*> expression

%start program

%%

program: %empty
       | program function_definitions
       | program statements
       ;

function_definitions: function_definition
                    | function_definitions function_definition
                    ;

function_definition: DEF IDENTIFIER LPAREN RPAREN LBRACE statements RBRACE
                   ;

statements: %empty
          | statements statement
          ;

statement: expression { std::cout << $1->value() << std::endl; }
         ;

expression: INTEGER PLUS INTEGER { $$ = new BinaryOpExpression($1, $3); }
          ;
%%

void Calculator::Parser::error(const location_type &l, const std::string &m) {
  std::cerr << "Error: " << m << "\n";
}
