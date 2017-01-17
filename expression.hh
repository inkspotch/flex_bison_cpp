#ifndef __EXPRESSION_HH__
#define __EXPRESSION_HH__

class Expression {
  public:
    virtual ~Expression(){}
    virtual int value() = 0;
};

class BinaryOpExpression : public Expression {
  public:
    BinaryOpExpression(int l, int r) : left(l), right(r) {}
    virtual ~BinaryOpExpression() {}
    virtual int value() override;
  private:
    int left;
    int right;
};

#endif
