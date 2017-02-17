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

%token DEF ASSIGN SEMICOLON
%token LPAREN RPAREN LBRACE RBRACE
%token PLUS MINUS MULT DIV 
%token END 0 

/*%type <Expression*> expression*/
%type <Expression*> factor term expression

%start program

%%

program: %empty 
       | program statement
       | program function
       ;

function: DEF IDENTIFIER LPAREN RPAREN LBRACE statements RBRACE
        ;

statements: %empty 
          | statements statement
          ;

statement: expression SEMICOLON { std::cout << "expression: " << $1->evaluate(); }
         | DEF IDENTIFIER ASSIGN expression SEMICOLON { std::cout << "assign: " << $4->evaluate();}
         ;

expression: term { $$ = new Number($1->evaluate()); }
          | expression PLUS term { $$ = new Number($1->evaluate() + $3->evaluate()); }
          | expression MINUS term { $$ = new Number($1->evaluate() - $3->evaluate()); }
          ;

term: factor { $$ = new Number($1->evaluate()); }
    | term MULT factor { $$ = new Number($1->evaluate() * $3->evaluate()); }
    | term DIV factor { $$ = new Number($1->evaluate() / $3->evaluate()); }
    ;

factor: LPAREN expression RPAREN { $$ = new Number($2->evaluate()); }
      | INTEGER { $$ = new Number($1); }
      ;
%%

void Calculator::Parser::error(const location_type &l, const std::string &m) {
  std::cerr << "Error: " << m << "\n";
}
