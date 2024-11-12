/*******************************************************************************
 * This calculates potential difference between a test point and many charges.
 * It then calculates the electric field by taking the gradient of the potential
 ******************************************************************************/

#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <vector>
#include <cmath>
#define SMALL 0.000001
using namespace std;

int readFile(string fileName, int &numCharges,
             vector< vector<double> > &charges, int &numPoints,
             vector< vector<double> > &points);

double calcPot(double q, double x1, double x2, double y1, double y2, double z1,
               double z2);

void resultCalc(int numCharges, vector< vector<double> > &charges,
                int numPoints, vector< vector<double> > &points,
                vector< vector<double> > &results);

void displaySaveFile(int numPoints, vector< vector<double> > points,
                     vector< vector<double> > results);

/*******************************************************************************
 * Main Loop
 ******************************************************************************/
int main(int argc, const char * argv[]) {
   
   // setup variables
   string fileName;
   int numCharges = 0;
   int numPoints = 0;                  // hold number points to test
   vector< vector<double> > charges;   // emulation fo integral, number of parts
   vector< vector<double> > points;    // test points
   vector< vector<double> > results;   // end result

   // enter filename as argument or as prompted here
   if (argc - 1) {
      fileName = argv[1];
   } else {
      cout << "Enter file name: ";
      getline(cin, fileName);
   }
   
   if (!readFile(fileName, numCharges, charges, numPoints, points))
      return 0;

   resultCalc(numCharges, charges, numPoints, points, results);
   
   displaySaveFile(numPoints, points, results);
   
   return 0;
}

/*******************************************************************************
 * Read in the file
 ******************************************************************************/
int readFile(string fileName, int &numCharges,
             vector< vector<double> > &charges, int &numPoints,
             vector< vector<double> > &points) {
   
   vector<double> bufferVector;
   double buffer;
   
   // let's read in this file!
   ifstream fin(fileName.c_str());
   
   if (fin.fail()) {
      cout << "File read failure" << endl;
      return 0;
   }
   
   // this reads in the file the way we are expecting it
   bool notDone = true;
   while (notDone) {
      
      // number of charges for use in looping later
      fin >> numCharges;
      for (int i = 0; i < numCharges; i++) {
         for (int j = 0; j < 4; j++) {
            fin >> buffer;
            if (j == 0) {
               buffer /= 1000000000;
            }
            bufferVector.push_back(buffer);
         }
         charges.push_back(bufferVector);
         bufferVector.clear();
      }
      
      // number of points for use in looping later
      fin >> numPoints;
      for (int i = 0; i < numPoints; i++) {
         for (int j = 0; j < 3; j++) {
            fin >> buffer;
            bufferVector.push_back(buffer);
         }
         points.push_back(bufferVector);
         bufferVector.clear();
      }
      
      notDone = false;
   }
   
   fin.close();
   
   return 1;
}

/*******************************************************************************
 * Simple potential calculator
 ******************************************************************************/
double calcPot(double q, double x1, double x2, double y1, double y2, double z1,
               double z2) {
   // V = kq/r
   return (8990000000*q) /
          sqrt( ((x2-x1)*(x2-x1)) + ((y2-y1)*(y2-y1)) + ((z2-z1)*(z2-z1)) );
}

/*******************************************************************************
 * Main result loop
 ******************************************************************************/
void resultCalc(int numCharges, vector< vector<double> > &charges,
                int numPoints, vector< vector<double> > &points,
                vector< vector<double> > &results) {

   // necessary variables initialized
   double x1 = 0.0;                    // point charge x
   double x2 = 0.0;                    // test point x
   double y1 = 0.0;                    // point charge y
   double y2 = 0.0;                    // test point y
   double z1 = 0.0;                    // point charge z
   double z2 = 0.0;                    // test point z
   double q  = 0.0;                    // q charge
   vector<double> bufferVector;
   
   // for each test points
   for (int i = 0; i < numPoints; i++) {
      x2 = points[i][0];
      y2 = points[i][1];
      z2 = points[i][2];
      
      // I'll need to initital a buffer vector here
      bufferVector.push_back(0.0);
      bufferVector.push_back(0.0);
      bufferVector.push_back(0.0);
      bufferVector.push_back(0.0);
      
      // now we go through the points.
      for (int j = 0; j < numCharges; j++) {
         q = charges[j][0];
         x1 = charges[j][1];
         y1 = charges[j][2];
         z1 = charges[j][3];
         
         // calculate voltage
         bufferVector[0] += calcPot(q, x1, x2, y1, y2, z1, z2);
         
         // calculate electric field by taking the gradient of the voltage
         bufferVector[1] += (calcPot(q, x1 + SMALL, x2, y1, y2, z1, z2) -
                             calcPot(q, x1, x2, y1, y2, z1, z2))/ SMALL;
         bufferVector[2] += (calcPot(q, x1, x2, y1 + SMALL, y2, z1, z2) -
                             calcPot(q, x1, x2, y1, y2, z1, z2))/ SMALL;
         bufferVector[3] += (calcPot(q, x1, x2, y1, y2, z1 + SMALL, z2) -
                             calcPot(q, x1, x2, y1, y2, z1, z2))/ SMALL;
      }
      
      // save to result and clean up the buffer
      results.push_back(bufferVector);
      bufferVector.clear();
   }
   
   return;
}

/*******************************************************************************
 * Prints out and saves in file 'results.txt'
 ******************************************************************************/
void displaySaveFile(int numPoints, vector< vector<double> > points,
                     vector< vector<double> > results) {
   ofstream fout("results.txt");
   fout.setf(ios::fixed);
   fout.precision(3);
   cout.setf(ios::fixed);
   cout.precision(3);
   
   for (int i = 0; i < numPoints; i++){
      // we probably want to see the results
      cout << "  " << i + 1 << ": ("
      << setw(7) << points[i][0] << ","
      << setw(7) << points[i][1] << ","
      << setw(7) << points[i][2] << ") V="
      << setw(7) << results[i][0] << " V E=<"
      << setw(7) << results[i][1] << ","
      << setw(7) << results[i][2] << ","
      << setw(7) << results[i][3] << "> N/C" << endl;
      
      // and we're saving results to file. Thank you, come again!
      fout << "  " << i + 1 << ": ("
      << setw(7) << points[i][0] << ","
      << setw(7) << points[i][1] << ","
      << setw(7) << points[i][2] << ") V="
      << setw(7) << results[i][0] << " V E=<"
      << setw(7) << results[i][1] << ","
      << setw(7) << results[i][2] << ","
      << setw(7) << results[i][3] << "> N/C" << endl;
   }

   fout.close();
   
   return;
}