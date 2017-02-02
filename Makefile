LEX=flex
YACC=bison

CXXSTD=-std=c++14

CXXFLAGS=-I/usr/local/opt/flex/include $(CXXSTD)

main: parser.tab.o lexer.yy.o calculator_driver.o main.o 
	$(CXX) $(CXXFLAGS) \
	-o interpreter $^ -L/usr/local/opt/flex/lib -lfl

parser.tab.cc: parser.yy
	$(YACC) -d $<

lexer.yy.o: lexer.yy.cc
	$(CXX) $(CXXFLAGS) \
	-c -o $@ $< 

lexer.yy.cc: lexer.ll 
	$(LEX) --outfile=lexer.yy.cc lexer.ll

.PHONY: clean
clean:
	rm -f interpreter
	rm -f *.o
	rm -f lexer.yy.*
	rm -f parser.tab.*
	rm -f position.hh stack.hh location.hh
