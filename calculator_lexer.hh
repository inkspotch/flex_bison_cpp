#ifndef __CALCULATOR_LEXER_HH__
#define __CALCULATOR_LEXER_HH__

#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "parser.tab.hh"
#include "location.hh"

namespace Calculator {

  class Lexer: public yyFlexLexer {
    public:
      Lexer(std::istream *in) : yyFlexLexer(in) { };
      virtual ~Lexer() { };

      virtual Calculator::Parser::symbol_type  lex();
  };
}

#endif

