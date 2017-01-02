#include <iostream>
#include <istream>

#include "calculator_driver.hh"
#include "parser.tab.hh"

int main(const int argc, const char **argv) {
  Calculator::Driver *driver = new Calculator::Driver();
  driver->parse(std::cin);
}

