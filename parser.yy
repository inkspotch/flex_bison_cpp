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
}

%parse-param { Lexer &lexer }

%code {
  #include <iostream>
  #include "calculator_lexer.hh"

  #undef yylex
  #define yylex lexer.lex
}


%token <int> INTEGER
%token <std::string> IDENTIFIER

%token DEF ASSIGN SEMICOLON
%token LPAREN RPAREN LBRACE RBRACE
%token PLUS MINUS MULT DIV 
%token END 0 

/*%type <Expression*> expression*/

%start program

%%

program: %empty 
       | program statement
       | program function ;

function: DEF IDENTIFIER LPAREN RPAREN LBRACE statements RBRACE
        ;

statements: %empty 
          | statements statement
          ;

statement: expression SEMICOLON
         | DEF IDENTIFIER ASSIGN expression SEMICOLON
         ;

expression: term 
          | expression PLUS term
          | expression MINUS term
          ;

term: factor
    | term MULT factor
    | term DIV factor
    ;

factor: LPAREN expression RPAREN
      | INTEGER
      ;
%%

void Calculator::Parser::error(const location_type &l, const std::string &m) {
  std::cerr << "Error: " << m << "\n";
}
