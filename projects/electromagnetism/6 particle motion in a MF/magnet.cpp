#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <vector>
#include <cmath>
#include <math.h>
#include "magnet.h"
#define U0 0.00000125663706143591729538505735331180115
using namespace std;

/*******************************************************************************
 * DEFAULT CONSTRUCTOR for MagneticField
 ******************************************************************************/
MagneticField::MagneticField() {
   elapsedTime = 0;
   // Need to initialize these
   for (int i = 0; i<3; i++)
      point.accel.push_back(0);
}

/*******************************************************************************
 * READ FILE
 *    Reads the file into all the variables and get them set up
 ******************************************************************************/
bool MagneticField::readFile(string fileName) {
   
   // let's read in this file!
   ifstream fin(fileName.c_str());
   
   if (fin.fail()) {
      cout << "File read failure" << endl;
      return 0;
   }
   
   // all the charges information
   double vMag;
   lineCharge temp;                             // we will have multiple lines
   int numCrntLines;
   fin >> numCrntLines;
   for (int i = 0; i < numCrntLines; i++) {
      fin >> temp.current;
      for (int i = 0; i < 3; i++) {
         fin >> buffer;                         // location
         temp.loc.push_back(buffer/100);        // because we need in meters
      }

      for (int i = 0; i < 3; i++) {
         fin >> buffer;                         // vectors
         temp.uVec.push_back(buffer);
      }
      
      // get the magnitude of vector
      vMag = sqrt(temp.uVec[0] * temp.uVec[0] + temp.uVec[1] * temp.uVec[1] +
                  temp.uVec[2] * temp.uVec[2]);
      
      // normalize x y z vectors here
      for (int i = 0; i < 3; i++)
         temp.uVec[i] /= vMag;
      
      // push onto lines vector
      lines.push_back(temp);
      
      // clean up for next loop
      temp.loc.clear();
      temp.uVec.clear();
   }

   // All the test point information0o
   fin >> buffer;
   point.mass = buffer / 1000;                  // because we need kg
   fin >> buffer;
   point.charge = buffer / 1000000000;          // because we need C
   
   for (int i = 0; i < 3; i++) {
      fin >> buffer;
      point.loc.push_back(buffer/100);          // cm -> m position
   }
   
   for (int i = 0; i < 3; i++) {
      fin >> buffer;
      point.vel.push_back(buffer/100);          // cm/s -> m/s
   }
   
   fin >> duration >> timeStp;
   
   fin.close();
   
   return true;
}

/*******************************************************************************
 * CROSS PRODUCT
 *    This function takes 2 xyz vectors and takes the cross product using 
 *    cofactor expansion.
 *
 *       | i j k |
 *       | a b c | = | b c | i - | a c | j + | a b | k
 *       | d e f |   | e f |     | d f |     | d e |
 ******************************************************************************/
vector<double> MagneticField::crossProduct(vector<double> M, vector<double> N) {
   vector<double> result;
   double a = M[0];
   double b = M[1];
   double c = M[2];
   double d = N[0];
   double e = N[1];
   double f = N[2];
   
   result.push_back(b*f - c*e);
   result.push_back(c*d - a*f);
   result.push_back(a*e - b*d);
   
   return result;
}

/*******************************************************************************
 * DOT PRODUCT
 *    returns the dot product of two vectors
 ******************************************************************************/
double MagneticField::dotProduct(vector<double> M, vector<double> N) {
   return (M[0]*N[0]) + (M[1]*N[1]) + (M[2]*N[2]);
}

/*******************************************************************************
 * CALCULATE TRAJECTORY
 *    There is a lot here. This gets the magnetic field at test point for each 
 *    charge line and superimposed them to get the total. Using that, we solve
 *    for acceleration using the force equation. Then apply kinematics to get 
 *    position and velocity
 ******************************************************************************/
void MagneticField::calcTrajectory() {
   vector<double> tempResults;
   vector<double> magField;   // magnetic field at test point
   vector<double> O;          // Vector pointing to testpoint
   vector<double> P;          // Projection onto line charge
   vector<double> Q;          // point on line closest to point of interest
   vector<double> R;          // distance from line to test point
   double r;                  // magnitude of R, distance to test point

   // necessary set up for vector data type to work
   for (int i = 0; i < 3; i++)
      magField.push_back(0);
   
   for (int i = 0; i < 7; i++)
      tempResults.push_back(0);
   
   // during the time we're told to calculate
   while (elapsedTime <= duration) {

      // loop for ever line charge
      for (int j = 0; j < lines.size(); j++) {
   
         // get vector point to test point
         for (int i = 0; i < 3; i++)
            O.push_back(point.loc[i] - lines[j].loc[i]);
   
         buffer = dotProduct(O, lines[j].uVec);
         
         // this works because it uses the value the line before in each case
         for (int i = 0; i < 3; i++) {
            P.push_back(buffer * lines[j].uVec[i]);   // projection onto line
            Q.push_back(lines[j].loc[i] + P[i]);      // point closest to point
            R.push_back(point.loc[i] - Q[i]);         // distance line - point
         }
         
         // magnitude of distance
         r = sqrt(R[0]*R[0] + R[1]*R[1] + R[2]*R[2]);
         
         bufferVector = crossProduct(lines[j].uVec, R);
         
         // calculates magnetic fields and adds to existing (superposition)
         for (int i = 0; i < 3; i++)
            magField[i] += (U0*lines[j].current*bufferVector[i]) / (2*M_PI*r*r);
         
         // housekeeping
         O.clear();
         P.clear();
         Q.clear();
         R.clear();
      }

      bufferVector = crossProduct(point.vel, magField);
      
      // calculate acceleration, position, velocity for x y z. Then saves.
      for (int i = 0; i < 3; i++) {
         point.accel[i] = (point.charge * bufferVector[i]) / point.mass;
         point.loc[i] += point.vel[i]*timeStp + .5*point.accel[i]*timeStp*timeStp;
         point.vel[i] += point.accel[i]*timeStp;
         magField[i] = 0;
         tempResults[i+1] = point.loc[i];
         tempResults[i+4] = point.vel[i];
      }
      
      // push onto results vector and increment to next step
      tempResults[0] = elapsedTime;
      results.push_back(tempResults);
      elapsedTime += timeStp;
   }
}

/*******************************************************************************
 * This saves our results vector to file.
 ******************************************************************************/
void MagneticField::saveFile() {
   ofstream fout("results.txt");
   fout.setf(ios::fixed);
   fout.precision(6);
   
   // we print to console as we save to file
   for (int i = 0; i < results.size(); i++){
      fout << setw(8) << results[i][0];
      for (int j = 1; j < 7; j++)
         fout << setw(11) << (results[i][j]*100);
      fout << endl;
   }
   
   fout.close();
   
   return;
}