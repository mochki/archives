#ifndef magnet_h
#define magnet_h

#include <vector>
using namespace std;

/*******************************************************************************
 * Line Charge Structure
 *    Holds current, location and normalized vector data
 ******************************************************************************/
struct lineCharge {
   double current;
   vector<double> loc;
   vector<double> uVec;
};

/*******************************************************************************
 * Test Point Structure
 *    Holds mass, charge, location, velocity and acceleration data
 ******************************************************************************/
struct testPoint {
   double mass;
   double charge;
   vector<double> loc;
   vector<double> vel;
   vector<double> accel;
};

/*******************************************************************************
 * Magnetic Field Class
 *    All data pertaining to calculating a magnetic field and a charge's 
 *    trajectory in said field
 ******************************************************************************/
class MagneticField {
public:
   MagneticField();
   ~MagneticField() { }
   
   // functions
   bool readFile(string fileName);        // takes file into usable data
   void calcTrajectory();                 // calculates trajectory
   void saveFile();                       // saves results to data
   
private:
   // declare variables
   vector <lineCharge> lines;
   testPoint point;
   vector< vector<double> > results;
   double duration;
   double timeStp;
   double elapsedTime;
   
   // buffer variables
   vector<double> bufferVector;
   double buffer;
   
   // functions
   vector<double> crossProduct(vector<double> M, vector<double> N);
   double dotProduct(vector<double> M, vector<double> N);
};

#endif /* magnet_h */
