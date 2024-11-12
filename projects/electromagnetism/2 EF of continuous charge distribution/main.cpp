/*******************************************************************************
 * This takes in a formatted input for a total charge of a cube, given the side
 * length and the center point in x, y, z coordinates. Then given some test
 * points, it will give the electrical field in x, y, z vectors. Saves to a 
 * results file and prints to console.
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
   int N = 400;                        // # points; 64,000,000 seems alright
   int numPoints = 0;                  // hold number points to test
   vector< vector<double> > charges;   // emulation fo integral, number of parts
   vector< vector<double> > points;    // test points
   vector<double> bufferVector;
   double buffer;
   vector< vector<double> > calcCharges;  // end result
   
   // constants and math things
   // cube things
   double bigQ = 0.0;
   double littleQ = 0.0;
   double sideLength = 0.0;
   double cubeX = 0.0;
   double cubeY = 0.0;
   double cubeZ = 0.0;
   
   // math things
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
   const double k = 8990000000.0;
   double R = 0.0;
   double Emag = 0.0;
   
   // components of E at point
   double xp = 0.0;
   double yp = 0.0;
   double zp = 0.0;
   
   // emulate integral - variables
   double xPoint = 0.0;
   double yPoint = 0.0;
   double zPoint = 0.0;
   double yTemp = 0.0;
   double zTemp = 0.0;

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
      fin >> bigQ >> sideLength >> cubeX >> cubeY >> cubeZ;
      
      // number of points for use in looping later
      fin >> numPoints;
      for (int i = 0; i < numPoints; i++) {
         for (int j = 0; j < 3; j++) {
            fin >> buffer;
            buffer /= 100;
            bufferVector.push_back(buffer);
         }
         points.push_back(bufferVector);
         bufferVector.clear();
      }
      
      notDone = false;
   }
   
   fin.close();
   
   // let's give proper units for our variables & set up mathing!
   bigQ /= 1000000000;
   littleQ = bigQ / (N * N * N);
   sideLength /= 100;
   cubeX /= 100;
   cubeY /= 100;
   cubeZ /= 100;
   xPoint = cubeX - (sideLength/2) - (sideLength/(2*N));
   yPoint = cubeY - (sideLength/2) - (sideLength/(2*N));
   zPoint = cubeZ - (sideLength/2) - (sideLength/(2*N));
   
   // here, we generate charge points and store it in a vector
   // based off the side length and x, y, z center of the cube
   // cycle z's on x,y then cycle y's (with z's too) then cylce all x and above
   for (int i = 1; i <= N; i++) {
      xPoint += (sideLength/N);        // adding x length of integral part
      bufferVector.push_back(xPoint);  // adding x location to bufferVector
      yTemp = yPoint;                  // reset y location every new x location
      for (int j = 1; j <= N; j++) {
         yTemp += (sideLength/N);      // same as above but different axis
         bufferVector.push_back(yTemp);
         zTemp = zPoint;
         for (int k =1; k <= N; k++) {
            zTemp += (sideLength/N);
            bufferVector.push_back(zTemp);
            charges.push_back(bufferVector);
            bufferVector.pop_back();   // keeps the x & y. z cycles
         }
         bufferVector.pop_back();      // cylces y
      }
      bufferVector.clear();            // cycles x
   }

   // declare and formatting for fout and cout
   ofstream fout("results.txt");
   fout.setf(ios::fixed);
   fout.precision(3);
   cout.setf(ios::fixed);
   cout.precision(3);

   
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
      
      for (int j = 0; j < (N*N*N); j++) {
         // setup charge
         x1 = charges[j][0];
         y1 = charges[j][1];
         z1 = charges[j][2];
         
         // disatance
         R = sqrt( ((x2-x1)*(x2-x1)) + ((y2-y1)*(y2-y1)) + ((z2-z1)*(z2-z1)) );
         
         // unit vectors
         xu = ((x2-x1) / R);
         yu = ((y2-y1) / R);
         zu = ((z2-z1) / R);
         
         // Energy Field Magnitude
         Emag = ((k*littleQ) / (R*R));
         
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
      << setw(7) << (points[i][0] * 100) << ","
      << setw(7) << (points[i][1] * 100) << ","
      << setw(7) << (points[i][2] * 100) << ") E=<"
      << setw(11) << calcCharges[i][0] << ","
      << setw(11) << calcCharges[i][1] << ","
      << setw(11) << calcCharges[i][2] << "> N/C" << endl;
      
      // and we're saving results to file. Thank you, come again!
      fout << "  " << i + 1 << ": ("
      << setw(7) << points[i][0] << ","
      << setw(7) << points[i][1] << ","
      << setw(7) << points[i][2] << ") E=<"
      << setw(11) << calcCharges[i][0] << ","
      << setw(11) << calcCharges[i][1] << ","
      << setw(11) << calcCharges[i][2] << "> N/C" << endl;
      
   }
   
   fout.close();
   
   return 0;
}