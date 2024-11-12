# Physics Computational Exercise 4
a.out:  ElectricFieldObject.o main.o
	g++ -o a.out  ElectricFieldObject.o main.o
	tar -cf prj4.tar *.h *.cpp makefile

ElectricFieldObject.o : ElectricFieldObject.cpp ElectricFieldObject.h
	g++ -c ElectricFieldObject.cpp

main.o: main.cpp ElectricFieldObject.h
	g++ -c main.cpp
