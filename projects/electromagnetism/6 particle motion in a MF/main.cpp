#include <iostream>
#include <string>
#include "magnet.h"
using namespace std;

/*******************************************************************************
 * MAIN 
 ******************************************************************************/
int main(int argc, const char * argv[]) {
   
   // setup variables
   MagneticField field;
   string fileName;
   
   // enter filename as argument or as prompted here
   if (argc - 1) {
      fileName = argv[1];
   } else {
      cout << "Enter file name: ";
      getline(cin, fileName);
   }
   
   // Ends program with message if file read fail
   if (!field.readFile(fileName))
      return 0;
   
   // All the calculation and save file
   field.calcTrajectory();
   field.saveFile();
   cout << "Calculations completed. Results saves in 'results.txt'" << endl;
   
   return 0;
}