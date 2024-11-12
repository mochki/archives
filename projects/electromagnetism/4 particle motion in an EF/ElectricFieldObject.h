#ifndef ElectricFieldObject_h
#define ElectricFieldObject_h

#include <vector>
#include <string>
using namespace std;

/*******************************************************************************
 * This hold all the information we need for our Elctric Field Object.
 ******************************************************************************/
class ElectricFieldObject {
public:
   ElectricFieldObject() : elapsedTime(0) { }
   ~ElectricFieldObject() { }
   
   int readFile(string fileName);         // takes file into usable data
   void calcTrajectory();                 // calculates entire trajectory
   void saveFile();                       // saves the resultant data to file
   
private:
   // setup variables - the names are pretty self explanatory
   vector< vector<double> > chrgs;
   double pntMass;
   double pntChrg;
   double time;
   double timeStp;
   vector<double> pntPos;
   vector<double> pntVel;
   vector< vector<double> > rslts;
   
   double scalar;
   double elapsedTime;
   vector<double> accel;
   vector<double> elecField;
   
   // these are needed to calculate the electric field
   double q;
   double x1;
   double y1;
   double z1;
   double x2;
   double y2;
   double z2;
   
   vector<double> bufferVector;
   double buffer;
   
   double calcPotVanilla();
   double calcPotX();
   double calcPotY();
   double calcPotZ();
   
   void elecFieldCalc();
   void pushResults();
};

#endif /* ElectricFieldObject_h */