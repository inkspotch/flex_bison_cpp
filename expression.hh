#ifndef __EXPRESSION_HH__
#define __EXPRESSION_HH__

class Expression {
  public:
    virtual ~Expression(){}
    virtual Expression* eval() = 0;
};

class BinaryOpExpression : public Expression {
  public:
    BinaryOpExpression(Operation *o, Expression *l, Expression *r) 
      : operation(o), left(l), right(r) {}
    virtual ~BinaryOpExpression() {}
    virtual Expression* eval() override;
  private:
    Operation *operation;
    Expression *left;
    Expression *right;
};

#endif
