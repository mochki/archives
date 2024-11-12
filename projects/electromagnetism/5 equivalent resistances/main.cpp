#include <iostream>
#include <string>
#include "Circuit.h"
using namespace std;

/*******************************************************************************
 * MAIN 
 *    Inititates a network of resistors, reads the data in from a file, 
 *    calculates the equivalent total resistance and prints and saves that data.
 ******************************************************************************/
int main(int argc, const char * argv[]) {
   
   // setup variables
   Circuit network;
   string fileName;
   
   // enter filename as argument or as prompted here
   if (argc - 1) {
      fileName = argv[1];
   } else {
      cout << "Enter file name: ";
      getline(cin, fileName);
   }
   
   // Ends program with message if file read fail
   if (!network.readFile(fileName))
      return 0;
   
   // All the calculations and results file output
   network.calcEq();
   network.displaySaveFile();
   
   return 0;
}