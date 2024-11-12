#include <iostream>
#include <string>
#include "ElectricFieldObject.h"
using namespace std;

/*******************************************************************************
 * Main Loop: This program creates an Electric Field Object and after reading in
 * data supplying point charges and a test point's initial position and velocity
 * it prints out an approximated trajectory
 ******************************************************************************/
int main(int argc, const char * argv[]) {
   
   // setup variables
   ElectricFieldObject eF;
   string fileName;
   
   // enter filename as argument or as prompted here
   if (argc - 1) {
      fileName = argv[1];
   } else {
      cout << "Enter file name: ";
      getline(cin, fileName);
   }
   
   // Ends program with message if file read fail
   if (!eF.readFile(fileName))
      return 0;
   
   // All the calculations and results file output
   eF.calcTrajectory();
   eF.saveFile();
   
   return 0;
}