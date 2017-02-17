#ifndef __EXPRESSION_HH__
#define __EXPRESSION_HH__

class Expression {
  public: 
    virtual ~Expression() {}
    virtual int evaluate() = 0;
};

class Number : public Expression {
  public:
    Number(int number) : number(number) {}
    ~Number () {}
    int evaluate() { return number; }
  private:
    int number;
};

#endif
