#ifndef Circuit_h
#define Circuit_h

#include <string>
using namespace std;

/*******************************************************************************
 * CLASS CIRCUIT
 *    Object that has a circuit network as a string and functions to equate the
 *    total resistance.
 ******************************************************************************/
class Circuit {
public:
   Circuit() : total(0), i(0) { }         // Default Constructor
   ~Circuit() { }                         // Deconstructor
   
   int readFile(string fileName);         // Takes file into usable data
   void calcEq();                         // Calculates equivalent resistance
   void displaySaveFile();                // Prints and saves the resultant data
   
private:
   string circuit;                        // Circuit netowrk
   double total;                          // Total Resistance
   int i;                                 // Itertor
   
   void series();                         // Calculates input range in series
   double parallel();                     // Calculates input range in parallel
};

#endif /* Circuit_h */