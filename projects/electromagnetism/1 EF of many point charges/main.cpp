/*******************************************************************************
 * This program takes in some data on charges and test points and returns the
 * net electrical field at those points. Can pass filename as argument when
 * running the program or will be prompted to do so. Prints result to console
 * and file called "results.txt"
 ******************************************************************************/

#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <vector>
#include <cmath>
using namespace std;

int main(int argc, const char * argv[]) {

   // setup variables, I feel like this a lot but whatever
   string fileName;
   int numCharges = 0;                 // hold number of charges in enviroment
   int numPoints = 0;                  // hold number points to test
   vector< vector<string> > strCharges;  // this holds the charges (string val)
   vector< vector<string> > strPoints;   // this holds the points (string val)
   vector<string> strBufferVector;     // needed as a read/temp buffer
   string strBuffer;
   
   // double accuracy is probably over kill, but all in the sake of precision?
   vector< vector<double> > charges;     // same, but usable float values
   vector< vector<double> > points;
   vector<double> bufferVector;
   double buffer;
   vector< vector<double> > calcCharges;
   
   // constants and math things
   // I could totally do the math making vector index calls but this looks clean
   // components
   double x1 = 0.0;  // point charge x
   double x2 = 0.0;  // test point x
   double xu = 0.0;  // unit vector for charge x
   double y1 = 0.0;  // point charge y
   double y2 = 0.0;  // test point y
   double yu = 0.0;  // unit vector for charge y
   double z1 = 0.0;  // point charge z
   double z2 = 0.0;  // test point z
   double zu = 0.0;  // unit vector for charge z
   
   // equation variables
   double q = 0.0;
   const double k = 8990000000.0;
   double R = 0.0;
   double Emag = 0.0;
   
   // components of E at point
   double xp = 0.0;
   double yp = 0.0;
   double zp = 0.0;
   
   // formatting for cout
   cout.setf(ios::fixed);
   cout.precision(3);
   
   
   // If want, you can enter filename as argument when running file.
   // Otherwise you are prompted here to enter file name
   if (argc - 1) {
      fileName = argv[1];
   } else {
      cout << "Enter file name: ";
      getline(cin, fileName);
   }
   
   
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
            fin >> strBuffer;
            strBufferVector.push_back(strBuffer);
         }
         strCharges.push_back(strBufferVector);
         strBufferVector.clear();
      }
      
      // number of points for use in looping later
      fin >> numPoints;
      for (int i = 0; i < numPoints; i++) {
         for (int j = 0; j < 3; j++) {
            fin >> strBuffer;
            strBufferVector.push_back(strBuffer);
         }
         strPoints.push_back(strBufferVector);
         strBufferVector.clear();
      }
      
      notDone = false;
   }
   
   fin.close();
   
   
   // here we make these all floats
   for (int i = 0; i < numCharges; i++) {
      for (int j = 0; j < 4; j++) {
         buffer = stof(strCharges[i][j]);
         if (j == 0)
            buffer /= 1000000000;
         bufferVector.push_back(buffer);
      }
      charges.push_back(bufferVector);
      bufferVector.clear();
   }

   for (int i = 0; i < numPoints; i++) {
      for (int j = 0; j < 3; j++) {
         buffer = stof(strPoints[i][j]);
         bufferVector.push_back(buffer);
      }
      points.push_back(bufferVector);
      bufferVector.clear();
   }
   
   // declare and formatting for fout
   ofstream fout("results.txt");
   fout.setf(ios::fixed);
   fout.precision(3);
   
   
   // this is the charge calculating part
   for (int i = 0; i < numPoints; i++) {
      // setup points
      x2 = points[i][0];
      y2 = points[i][1];
      z2 = points[i][2];
      
      // initialize
      bufferVector.push_back(0.0);
      bufferVector.push_back(0.0);
      bufferVector.push_back(0.0);
      
      for (int j = 0; j < numCharges; j++) {
         // setup charge
         q = charges[j][0];
         x1 = charges[j][1];
         y1 = charges[j][2];
         z1 = charges[j][3];
         
         // disatance
         R = sqrt( ((x2-x1)*(x2-x1)) + ((y2-y1)*(y2-y1)) + ((z2-z1)*(z2-z1)) );
         
         // unit vectors
         xu = ((x2-x1) / R);
         yu = ((y2-y1) / R);
         zu = ((z2-z1) / R);
         
         // Energy Field Magnitude
         Emag = ((k*q) / (R*R));
         
         // Components of E at point
         xp = Emag * xu;
         yp = Emag * yu;
         zp = Emag * zu;
         
         // Accumulative values at test points
         bufferVector[0] += xp;
         bufferVector[1] += yp;
         bufferVector[2] += zp;
      }
      
      // finishing up here
      calcCharges.push_back(bufferVector);
      bufferVector.clear();   // and reset
      
      // we probably want to see the results
      cout << "  " << i + 1 << ": ("
           << setw(7) << points[i][0] << ","
           << setw(7) << points[i][1] << ","
           << setw(7) << points[i][2] << ") E=<"
           << setw(7) << calcCharges[i][0] << ","
           << setw(7) << calcCharges[i][1] << ","
           << setw(7) << calcCharges[i][2] << "> N/C" << endl;
      
      // and we're saving results to file. Thanks you, come again!
      fout << "  " << i + 1 << ": ("
           << setw(7) << points[i][0] << ","
           << setw(7) << points[i][1] << ","
           << setw(7) << points[i][2] << ") E=<"
           << setw(7) << calcCharges[i][0] << ","
           << setw(7) << calcCharges[i][1] << ","
           << setw(7) << calcCharges[i][2] << "> N/C" << endl;
      
   }
   
   fout.close();
   
   return 0;
}