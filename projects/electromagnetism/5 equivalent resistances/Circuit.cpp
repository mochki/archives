#include <iostream>                 // std CIN COUT
#include <iomanip>                  // formatting COUT FOUT
#include <fstream>                  // file read/write
#include <string>                   // string data type
#include <vector>                   // for vector data type
#include "Circuit.h"
using namespace std;

/*******************************************************************************
 * READ FILE
 *    Reads the file into all the variables we need
 ******************************************************************************/
int Circuit::readFile(string fileName) {
   
   string buffer;
   
   // Let's read in this file!
   ifstream fin(fileName.c_str());
   
   if (fin.fail()) {
      cout << "File read failure" << endl;
      return 0;
   }
   
   while (fin >> buffer) {
      circuit += buffer + " ";
   }
   
   fin.close();
   
   return 1;
}

/*******************************************************************************
 * SERIES
 *    Gets called and calculates entire circuit in series. When it sees a
 *    parallel branch, it gets equivalent resistance by calling parallel() and 
 *    adds that in series.
 ******************************************************************************/
void Circuit::series() {
   int j = 0;                             // Offset for numbers
   bool notDone = true;
   
   // Loops through entire circuit, checks positions for different structure
   while (notDone) {
      if (circuit[i] == ' ')
         i++;
      else if (circuit[i] == '[') {
         // Call a seperate branch to calculate parallel equivalent
         i++;
         total += parallel();
      } else if (isdigit(circuit[i])) {
         // How long is the number?
         j = 1;
         while (isdigit(circuit[i+j]) || circuit[i+j] == '.') {
            j++;
         }
         // Start and ending location of number added to total
         total += stod(circuit.substr(i, j));
         i += j;
         j = 0;
      } else if (circuit[i] == 'X')
         notDone = false;                 // We're done!
   }
}

/*******************************************************************************
 * PARALLEL
 *    Function that takes the values in between the [ ] and returns the 
 *    equivalent resistance. If it sees another parallel branch, it calls the 
 *    parallel() function.
 ******************************************************************************/
double Circuit::parallel() {
   int k = 0;                             // Offset for numbers
   bool notDone = true;
   double parBuf = 0;
   vector<double> pll;                    // Container for parallel resistors
   
   // Loops through range, checking positions for different structures
   while (notDone) {
      if (circuit[i] == ' ')
         i++;
      else if (circuit[i] == ']') {
         // Signifies an end of a parallel branch, exit loop
         pll.push_back(parBuf);
         parBuf = 0;
         i++;
         notDone = false;
      } else if (isdigit(circuit[i])) {
         // How  long is the number?
         k = 1;
         while (isdigit(circuit[i+k]) || circuit[i+k] == '.') {
            k++;
         }
         // Start and endling location of number added to the buffer
         parBuf += stod(circuit.substr(i, k));
         i += k;
         k = 0;
      } else if (circuit[i] == ',') {
         // Signifies another branch in parallel
         pll.push_back(parBuf);
         parBuf = 0;
         i++;
      } else if (circuit[i] == '[') {
         // Signifies a parallel branch and calls parallel() to get equivalence
         i++;
         parBuf += parallel();
      }
   }
   
   // We have all the branch values now. Calculate and return equivalence
   for (int l = 0; l < pll.size(); l++)
      parBuf += 1/pll[l];
   parBuf = 1/parBuf;
   
   return parBuf;
}

/*******************************************************************************
 * CALCEQ
 *    Calls private function series() and that calculates total resistance
 ******************************************************************************/
void Circuit::calcEq() {
   series();                               // This is a great function
}

/*******************************************************************************
 * DISPLAYSAVEFILE
 *    Takes the 'total' variable and prints it to screen and saves it to file
 ******************************************************************************/
void Circuit::displaySaveFile() {
   ofstream fout("results.txt");
   fout.setf(ios::fixed);
   cout.setf(ios::fixed);
   fout.precision(4);
   cout.precision(4);
   
   fout << "The equivalent resistance is " << total;
   cout << "The equivalent resistance is " << total << endl;
   
   fout.close();
   
   return;
}