#include "calculator_driver.hh"

Calculator::Driver::~Driver() {
  delete(lexer);
  lexer = nullptr;
}

void Calculator::Driver::parse(std::istream &stream) {
  lexer = new Calculator::Lexer(&stream);
  Calculator::Parser *parser = new Calculator::Parser(*lexer);
  parser->parse();
}

