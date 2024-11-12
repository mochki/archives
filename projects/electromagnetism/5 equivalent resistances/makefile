################################################################################
# Program:
#     Calculating Equivalent Resistances
# Author:
#     mochki
# Summary:
#     This calculates equivalent total resistance of a circuit given in an input
#     file.
################################################################################

################################################################################
# The Main Rule
################################################################################
a.out:  circuit.o main.o
	g++ -o a.out  circuit.o main.o
	tar -cf prj5.tar *.h *.cpp makefile

################################################################################
# The Individual Components
#     main.o            : int main(), driver program
#     circuit.o         : Circuit object and functions to calculate equivalence
################################################################################
main.o: circuit.h main.cpp
	g++ -c main.cpp

circuit.o : circuit.h circuit.cpp
	g++ -c circuit.cpp

################################################################################
# If you feel the need to clean the air (which I do) this
# command is available.
################################################################################
clean:
	rm -r *.o

delete:
	rm -r *.o *.out *.tar