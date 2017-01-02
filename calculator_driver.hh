#ifndef __CALCULATOR_DRIVER_HH__
#define __CALCULATOR_DRIVER_HH__

#include <istream>

#include "calculator_lexer.hh"
#include "parser.tab.hh"

namespace Calculator {
  class Driver {
    public:
      Driver() = default;
      virtual ~Driver();

      void parse(std::istream &stream);

    private:
      Calculator::Lexer *lexer = nullptr;
  };
}

#endif
