#include "expression.hh"

int BinaryOpExpression::value() {
  return left + right;
}
