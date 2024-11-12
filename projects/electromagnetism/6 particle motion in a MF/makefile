################################################################################
# Program:
#     Motion of a Charged Particle in a Magnetic Field
# Author:
#     mochki
# Summary:
#     This calculates the trajectory of a point charge through a magnetic field
################################################################################

################################################################################
# The Main Rule
################################################################################
a.out:  magnet.o main.o
	g++ -o a.out magnet.o main.o
	tar -cf prj6.tar *.h *.cpp makefile

################################################################################
# The Individual Components
#     main.o           : int main(), driver program
#     magnet.o         : Everything to calculate a magnetic field and use it for
#                      : kinematics of a charged particle
################################################################################
main.o: magnet.h main.cpp
	g++ -c main.cpp

magnet.o : magnet.h magnet.cpp
	g++ -c magnet.cpp

################################################################################
# If you feel the need to clean the air (which I do) this
# command is available.
################################################################################
clean:
	rm -r *.o

delete:
	rm -r *.o *.out *.tar
