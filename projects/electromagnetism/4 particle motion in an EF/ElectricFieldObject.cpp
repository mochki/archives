#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <vector>
#include <cmath>
#include "ElectricFieldObject.h"
#define SMALL 0.0000001
using namespace std;

/*******************************************************************************
 * Reads the file into all the variables we need
 ******************************************************************************/
int ElectricFieldObject::readFile(string fileName) {
   
   // let's read in this file!
   ifstream fin(fileName.c_str());
   
   if (fin.fail()) {
      cout << "File read failure" << endl;
      return 0;
   }
   
   // All the charges information
   int numChrgs;
   fin >> numChrgs;
   for (int i = 0; i < numChrgs; i++) {
      for (int j = 0; j < 4; j++) {
         fin >> buffer;
         if (j == 0)
            buffer /= 1000000000;         // charge given in nC
         else
            buffer /= 100;                // position given in cm
         
         bufferVector.push_back(buffer);
      }
      chrgs.push_back(bufferVector);
      bufferVector.clear();
   }
   
   // All the test point information
   fin >> buffer;
   pntMass = buffer/ 1000;                // mass given in g, needs to be kg
   fin >> buffer;
   pntChrg = buffer / 1000000000;         // charge given in nC
   for (int i = 0; i < 3; i++) {
      fin >> buffer;
      buffer /= 100;                      // position given in cm
      pntPos.push_back(buffer);
   }
   for (int i = 0; i < 3; i++) {
      fin >> buffer;
      buffer /= 100;                      // velocity given in cm/s
      pntVel.push_back(buffer);
   }
   fin >> time >> timeStp;                // times given in seconds
   
   fin.close();
   
   return 1;
}


/*******************************************************************************
 * Simple potential calculator
 ******************************************************************************/
double ElectricFieldObject::calcPotVanilla() {
   return (8990000000*q) /
   sqrt( ((x2-x1)*(x2-x1)) + ((y2-y1)*(y2-y1)) + ((z2-z1)*(z2-z1)) );
}

/*******************************************************************************
 * Potential calculator with deltaX
 ******************************************************************************/
double ElectricFieldObject::calcPotX() {
   return (8990000000*q) /
   sqrt(((x2-x1+SMALL)*(x2-x1+SMALL))+((y2-y1)*(y2-y1))+((z2-z1)*(z2-z1)));
}

/*******************************************************************************
 * Potential calculator with deltaY
 ******************************************************************************/
double ElectricFieldObject::calcPotY() {
   return (8990000000*q) /
   sqrt(((x2-x1)*(x2-x1))+((y2-y1+SMALL)*(y2-y1+SMALL))+((z2-z1)*(z2-z1)));
}

/*******************************************************************************
 * Potential calculator with deltaZ
 ******************************************************************************/
double ElectricFieldObject::calcPotZ() {
   return (8990000000*q) /
   sqrt(((x2-x1)*(x2-x1))+((y2-y1)*(y2-y1))+((z2-z1+SMALL)*(z2-z1+SMALL)));
}

/*******************************************************************************
 * This calculates our electric field
 ******************************************************************************/
void ElectricFieldObject::elecFieldCalc() {
   x2 = pntPos[0];          // test point x
   y2 = pntPos[1];          // test point y
   z2 = pntPos[2];          // test point z
   
   // clear and set up for calculations
   elecField.clear();
   elecField.push_back(0.0);
   elecField.push_back(0.0);
   elecField.push_back(0.0);
   
   // now we go through the points.
   for (int i = 0; i < chrgs.size(); i++) {
      q  = chrgs[i][0];
      x1 = chrgs[i][1];
      y1 = chrgs[i][2];
      z1 = chrgs[i][3];
      
      // calculate electric field by taking the gradient of the voltage
      elecField[0] += (calcPotX() - calcPotVanilla())/ SMALL;
      elecField[1] += (calcPotY() - calcPotVanilla())/ SMALL;
      elecField[2] += (calcPotZ() - calcPotVanilla())/ SMALL;
   }
   
   elecField[0] *= -1;
   elecField[1] *= -1;
   elecField[2] *= -1;
   
   return;
}

/*******************************************************************************
 * This calculates the trajectory of the test point by iterating through each 
 * step of time
 ******************************************************************************/
void ElectricFieldObject::calcTrajectory() {
   // this is from a = F/m and F = qE - therefore q/m is the scalar
   scalar = pntChrg / pntMass;
   
   // loop until we've gotten to our time period
   while (elapsedTime <= time) {
      // we get the electric field
      elecFieldCalc();
      
      // we get the accleration for x y z
      accel.push_back(scalar*elecField[0]);
      accel.push_back(scalar*elecField[1]);
      accel.push_back(scalar*elecField[2]);
      
      // Rf(t + dt) = Ri + Vi(t)*dt + 1/2*a(t)*(dt^2)
      pntPos[0] += pntVel[0]*timeStp + 0.5*accel[0]*(timeStp*timeStp);
      pntPos[1] += pntVel[1]*timeStp + 0.5*accel[1]*(timeStp*timeStp);
      pntPos[2] += pntVel[2]*timeStp + 0.5*accel[2]*(timeStp*timeStp);
      
      // Vf(t + dt) = Vi(t) + a(t)*dt
      pntVel[0] += accel[0]*timeStp;
      pntVel[1] += accel[1]*timeStp;
      pntVel[2] += accel[2]*timeStp;
      
      // Save results, and setup for next iteration
      pushResults();
      accel.clear();
      elapsedTime += timeStp;
   }
   
}

/*******************************************************************************
 * This pushes the results into our results vector
 ******************************************************************************/
void ElectricFieldObject::pushResults() {
   bufferVector.push_back(elapsedTime);
   bufferVector.push_back(pntPos[0] * 100);
   bufferVector.push_back(pntPos[1] * 100);
   bufferVector.push_back(pntPos[2] * 100);
   bufferVector.push_back(pntVel[0] * 100);
   bufferVector.push_back(pntVel[1] * 100);
   bufferVector.push_back(pntVel[2] * 100);
   
   rslts.push_back(bufferVector);
   
   bufferVector.clear();
}

/*******************************************************************************
 * This saves our results vector to file.
 ******************************************************************************/
void ElectricFieldObject::saveFile() {
   ofstream fout("results.txt");
   fout.setf(ios::fixed);
   cout.setf(ios::fixed);
   
   // we print to console as we save to file
   for (int i = 0; i < rslts.size(); i++){
      fout.precision(6);
      fout << setw(9) << rslts[i][0];
      fout.precision(3);
      fout << setw(8) << rslts[i][1]
      << setw(8) << rslts[i][2]
      << setw(8) << rslts[i][3]
      << setw(8) << rslts[i][4]
      << setw(8) << rslts[i][5]
      << setw(8) << rslts[i][6] << endl;
   }
   
   fout.close();
   
   return;
}
