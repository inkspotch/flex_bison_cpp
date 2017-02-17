#ifndef __BINARY_OPERATION_HH__
#define __BINARY_OPERATION_HH__

#include "expression.hh"

class BinaryOperation : public Expression {
  virtual ~BinaryOperation() {};
};

class AddOperation : public BinaryOperation {
  public:
    AddOperation(Expression *e1, Expression *e2) : e1(e1), e2(e2) {}

    override int evaluate() {
      return e1->evaluate() + e2->evaluate();
    }

  private:
    Expression *e1;
    Expression *e2;
};

#endif
