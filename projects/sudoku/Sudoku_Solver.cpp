/**************************************************************************************************
* Author:
*    mochki
* Summary:
*    This will open a Sudoku board given by the user. A user can see what
*    possible values are available for a certain square. They can also write
*    a value to a square and save the current board to a file. Basically,
*    they can play sudoku with a lot of assistance.
*    EDIT:
*    We can now completely solve the puzzle. Type F and it will solve any
*    puzzle.
*
*    I wrote this program before I knew about OOP. I also don't care about 80 columns wide anymore.
*    Also, wow. This program is buggy. It solves pretty well. Maybe one day I'll come back and write
*    all this cleaner and more secure.
***************************************************************************************************/
#include <iostream>
#include <string>
#include <fstream>
#include <cstdlib>
#include <bitset>
using namespace std;

string getFilename();
void readBoard(string filename, int sudokuData[][9]);
void displayHelp();
void displaySudoku(int sudokuData[][9]);
void writeFile(int sudokuData[][9]);
int getCoordinates(int sudokuData[][9], int rowCol[2]);
void editOneSquare(int &nineBooleans, int rowCol[2], int sudokuData[][9]);
bool computeValues(int &nineBooleans, int rowCol[2], int sudokuData[][9]);
void showPosVal(int &nineBooleans, int rowCol[2], int sudokuData[][9]);
bool unsolvedCoordinate(int sudokuData[][9], int &row, int &column);
bool solveMagicStart1(int sudokuData[][9]);
bool solveMagicStart9(int sudokuData[][9]);
bool validate(int sudokuData[][9], int row, int col, int num);
bool checkStartNumber(int sudokuData[][9]);
void interact(int sudokuData[][9], bool &runAgain, int &nineBooleans, int rowCol[2]);

/**********************************************************************
 * MAIN
 * Calls all the functions to get filename, display help and sudoku, and
 * interact - which lets the user exercise all freedom in sudoku board
 * cheating and manipulation
 ***********************************************************************/
int main() {
   string filename;
   filename = getFilename(); //grabs the filename from user

   int sudokuData[9][9]; //multi-dimensional array for the whole sudoku
   readBoard(filename, sudokuData); //reads from file and save to array

   displayHelp(); //shows options initially
   displaySudoku(sudokuData); //shows sudoku table initially

   bool runAgain = true; //will keep prompt alive unless otherwise set
   int nineBooleans = 0b111111111; //initiate booleans for 9 values
   int rowCol[2] = {}; //initiate the coordinate array

   do {
      interact(sudokuData, runAgain, nineBooleans, rowCol);
   } while (runAgain);

   return 0;
}

/**********************************************************************
 * Simply grabs the filename from the user - pretty self-explanatory
 ***********************************************************************/
string getFilename() {
   string filename;
   cout << "Where is your board located? ";
   getline(cin, filename);

   return filename;
}

/**********************************************************************
 * Actually grabs the data and saves into multidimensional array
 ***********************************************************************/
void readBoard(string filename, int sudokuData[][9]) {
   ifstream fin(filename.c_str()); //needed to use string

   if (fin.fail())
      return; //stops if it fails to read the file

   for (int i = 0; i < 9; i++) {
      for (int t = 0; t < 9; t++) {
         fin >> sudokuData[i][t]; //a position in 9 x 9 array
      }
   }

   fin.close();
}

/**********************************************************************
 * Function that is and can be called to display possible actions
 ***********************************************************************/
void displayHelp() {
   cout << "Options:\n"
        << "   ?  Show these instructions\n"
        << "   D  Display the board\n"
        << "   E  Edit one square\n"
        << "   S  Show the possible values for a square\n"
        << "   F  Finish the Puzzle\n"
        << "   Q  Save and Quit\n\n";
}

/**********************************************************************
 * Function that is and can be called to display the current Sudoku table
 ***********************************************************************/
void displaySudoku(int sudokuData[][9]) {
   cout << "   A B C D E F G H I\n"; //columns
   for (int i = 0; i < 9; i++) {
      cout << i + 1 << "  "; //row number
      for (int t = 0; t < 9; t++) {
         //just checking, if it's a zero, put a space!
         sudokuData[i][t] == 0 ? cout << " " : cout << sudokuData[i][t];
         switch (t) {
            case 2:
            case 5:
               cout << "|";
               break;
            case 8:
               cout << endl;
               break;
            default:
               cout << " ";
         }
      }
      if (i == 2 || i == 5)
         cout << "   -----+-----+-----\n";
   }
}

/**********************************************************************
 * Function that will write the sudoku table to a specified file
 ***********************************************************************/
void writeFile(int sudokuData[][9]) {
   string newFilename;
   cout << "What file would you like to write your board to: ";
   cin.ignore();
   getline(cin, newFilename);

   ofstream fout(newFilename.c_str());

   for (int i = 0; i < 9; i++) {
      for (int t = 0; t < 9; t++) {
         fout << sudokuData[i][t];
         //space between each number unless it is end of line
         t != 8 ? fout << " " : fout << "\n";
      }
   }
   fout.close();
   cout << "Board written successfully\n";
}

/**********************************************************************
 * Function used to get the coordinates from the user. Can be called from
 * another function because it is modular. Error checking provided.
 ***********************************************************************/
int getCoordinates(int sudokuData[][9], int rowCol[2]) {
   rowCol[0] = 0;
   rowCol[1] = 0; // always empty this out

   string coordinates;
   cout << "What are the coordinates of the square: ";
   cin.ignore();
   getline(cin, coordinates); //captured!

   //cycles through the first character to determine row or column
   if (coordinates[0] > 48 && coordinates[0] < 58)
      rowCol[0] = coordinates[0] - '1';
   else if (coordinates[0] > 64 && coordinates[0] < 91)
      rowCol[1] = coordinates[0] - 'A';
   else if (coordinates[0] > 96 && coordinates[0] < 123) //even if lowercase
      rowCol[1] = coordinates[0] - 'a';
   else
      return 1;
      //if it fails we return 1 that will stop things in an if statement

   //2nd character in string
   if (coordinates[1] > 48 && coordinates[1] < 58)
      rowCol[0] = coordinates[1] - '1';
   else if (coordinates[1] > 64 && coordinates[1] < 91)
      rowCol[1] = coordinates[1] - 'A';
   else if (coordinates[1] > 96 && coordinates[1] < 123)
      rowCol[1] = coordinates[1] - 'a';
   else
      return 1;
   //all set to the format we want. Row, Column

   if (rowCol[0] < 0 || rowCol[0] > 8 || rowCol[1] < 0 || rowCol[1] > 8) {
      cout << "ERROR: Square '" << coordinates << "' is invalid\n";
      return 1; //just in case, we can't have out of range numbers
   }

   if (sudokuData[rowCol[0]][rowCol[1]] > 0) {
      cout << "ERROR: Square '" << coordinates << "' is filled\n";
      return 1; //Oh no! There's already a number there.
   }

   return 0; //success!
}

/**********************************************************************
 * Here we have some bitwise magic. This will tell us which values are
 * possible, basically with 9 booleans.
 ***********************************************************************/
bool computeValues(int &nineBooleans, int rowCol[2], int sudokuData[][9]) {
   //always reset it back to this
   nineBooleans = 0b111111111; //9 bits for 9 values

   for (int i = 0; i < 9; i++) //vertical
      if (sudokuData[i][rowCol[1]] > 0) //column stays constant
         nineBooleans = nineBooleans & ~(1 << (sudokuData[i][rowCol[1]] - 1));
   //we set just the position of nineBooleans OFF of the number being
   //reference when that number is greater than zero

   for (int i = 0; i < 9; i++) //horizontal
      if (sudokuData[rowCol[0]][i] > 0) //row stays constant
         nineBooleans = nineBooleans & ~(1 << (sudokuData[rowCol[0]][i] - 1));
   //continue to do that in a different axis

   int blockRow = rowCol[0] / 3; //0, 1, 2 and 0, 1, 2 of which block
   int blockCol = rowCol[1] / 3;
   //loops through 3 x 3 of each block
   for (int x = blockRow * 3; x < blockRow * 3 + 3; x++)
      for (int y = blockCol * 3; y < blockCol * 3 + 3; y++)
         if (sudokuData[x][y] > 0)
            nineBooleans = nineBooleans & ~(1 << (sudokuData[x][y] - 1));
   //a little trickier but same concept

   //we should be left with a 9 bit that has 1's in the positions where the
   //number is possible
}

/**********************************************************************
 * Edits one square that the user picks with what the user decides. Error
 * checking is lovingly given
 ***********************************************************************/
void editOneSquare(int &nineBooleans, int rowCol[2], int sudokuData[][9]) {
   if (getCoordinates(sudokuData, rowCol)) //We need these
      return; //but if it fail, no go

   char colAlpha = 'A' + rowCol[1]; //only for the sake of printing it nicely
   int input = 0;
   cout << "What is the value at '" << colAlpha << rowCol[0] + 1 << "': ";
   cin >> input;

   if (input < 1 || input > 9) //It's got to be between 1 and 9
      cout << "ERROR: Value '" << input << "' in square '" << colAlpha
           << rowCol[0] + 1 << "' is invalid\n";
   //NaN breaks the program. Let's assume no one is going to try
   //something so stupid?

   computeValues(nineBooleans, rowCol, sudokuData);
   //from coordinate given, tells us what's possible

   //if that specific value is 1, meaning a legal move, than we can set it
   //otherwise, the value is not valid.
   if (nineBooleans & 1 << (input - 1))
      sudokuData[rowCol[0]][rowCol[1]] = input;
   else
      cout << "ERROR: Value '" << input << "' in square '" << colAlpha
           << rowCol[0] + 1 << "' is invalid\n";
}

/**********************************************************************
 * Shows the possible value for a square ascribed by the user
 ***********************************************************************/
void showPosVal(int &nineBooleans, int rowCol[2], int sudokuData[][9]) {
   if (getCoordinates(sudokuData, rowCol)) //we need these
      return; //but, just in case it don't work

   char colAlpha = 'A' + rowCol[1]; //for printing in prettiness

   //what's legal? Let's see those bitwise booleans
   computeValues(nineBooleans, rowCol, sudokuData);

   cout << "The possible values for '" << colAlpha << rowCol[0] + 1
        << "' are: ";

   int count = 0; //just so we don't have commas before the first number
   for (int bit = 0; bit < 9; bit++) {
      if (nineBooleans & 1 << bit) {
         if (count > 0) //see?
            cout << ", ";
         cout << bit + 1;
         count++;
      }
   }
   cout << endl;
}

/**********************************************************************
 * This ends up being a recursive function. It bruteforces every possible
 * comibination of numbers until every number fits and doesn't conflict.
 * This one starts at 9 and brute forces
 ***********************************************************************/
bool solveMagicStart9(int sudokuData[][9]) {
   //every iteration, these are specified
   int row;
   int column;
   //by this, it just finds the next open spot
   if (!unsolvedCoordinate(sudokuData, row, column))
      return true; //if all are close, and no problems thus far, we're solved

   for (int i = 9; i > 0; i--) {
      if (validate(sudokuData, row, column, i)) {
         sudokuData[row][column] = i; //sets it
         //function calls itself to try one number, than the next slot, etc
         //keeping them all running until everything has a number and it all
         //returns true
         if (solveMagicStart9(sudokuData))
            return true; //solved!
         //every iteration of the function that doesn't work, sets the place
         //back to 0
         sudokuData[row][column] = 0;
      }
   }

   return false;
}

/**********************************************************************
 * This ends up being a recursive function. It bruteforces every possible
 * comibination of numbers until every number fits and doesn't conflict.
 * This one starts at 1 and brute forces
 ***********************************************************************/
bool solveMagicStart1(int sudokuData[][9]) {
   //every iteration, these are specified
   int row;
   int column;
   //by this, it just finds the next open spot
   if (!unsolvedCoordinate(sudokuData, row, column))
      return true; //if all are close, and no problems thus far, we're solved

   for (int i = 0; i < 10; i++) {
      if (validate(sudokuData, row, column, i)) {
         sudokuData[row][column] = i; //sets it
         //function calls itself to try one number, than the next slot, etc
         //keeping them all running until everything has a number and it all
         //returns true
         if (solveMagicStart1(sudokuData))
            return true; //solved!
         //every iteration of the function that doesn't work, sets the place
         //back to 0
         sudokuData[row][column] = 0;
      }
   }

   return false;
}

/**********************************************************************
 * This just finds the next available spot in sudoku array to be used for
 * the next generation of brute forcing.
 ***********************************************************************/
bool unsolvedCoordinate(int sudokuData[][9], int &row, int &column) {
   for (row = 0; row < 9; row++)
      for (column = 0; column < 9; column++)
         if (sudokuData[row][column] == 0) //if equal zero,
            return true;

   return false;
}

/**********************************************************************
 * This is the same insides of the checkValue function from before, just
 * without the pass by references and such that make it unusable. It also
 * is a bool this time so it returns true if the number inputted is possible
 ***********************************************************************/
bool validate(int sudokuData[][9], int row, int col, int num) {
   int nineBooleans = 0b111111111;
   //Same thing as the check value, but stream lined for validating

   //plus it now returns that a value can't be in the spot right after
   //it fails. No point going through row, column, and block if it fails on
   //the row.
   for (int i = 0; i < 9; i++) {
      if (sudokuData[i][col] > 0)
         nineBooleans = nineBooleans & ~(1 << (sudokuData[i][col] - 1));
      if (!(nineBooleans & 1 << num - 1))
         return false;
   }

   for (int i = 0; i < 9; i++) {
      if (sudokuData[row][i] > 0)
         nineBooleans = nineBooleans & ~(1 << (sudokuData[row][i] - 1));
      if (!(nineBooleans & 1 << num - 1))
         return false;
   }

   int blockRow = row / 3;
   int blockCol = col / 3;
   for (int x = blockRow * 3; x < blockRow * 3 + 3; x++) {
      for (int y = blockCol * 3; y < blockCol * 3 + 3; y++) {
         if (sudokuData[x][y] > 0)
            nineBooleans = nineBooleans & ~(1 << (sudokuData[x][y] - 1));
         if (!(nineBooleans & 1 << num - 1))
            return false;
      }
   }

   if (num != 0)
      if (nineBooleans & 1 << num - 1)
         return true;

   return false;
}

/**********************************************************************
 * This just check if we should start from 1 or from 9 to brute force
 ***********************************************************************/
bool checkStartNumber(int sudokuData[][9]) {
   bool firstBlockHasOneTwoThreeFour = false;
   for (int i = 0; i < 3; i++)
      for (int t = 0; t < 3; t++)
         if (sudokuData[i][t] == 1 || sudokuData[i][t] == 2 || sudokuData[i][t] == 3 || sudokuData[i][t] == 4)
            firstBlockHasOneTwoThreeFour = true;

   return firstBlockHasOneTwoThreeFour;
}

/**********************************************************************
 * Almost as big as the main function itself, we got our main prompt
 * that is the dashboard for all the user does. He can see the options,
 * see the current Sudoku table, write the table to some designated file,
 * edit one square with what he wants, CHEAT! by seeing what values are
 * possible without his brain doing the work.
 * F - will solve it all.
 ***********************************************************************/
void interact(int sudokuData[][9], bool &runAgain, int &nineBooleans, int rowCol[2]) {
   char userInput;
   cout << "\n> ";
   cin >> userInput;

   switch (userInput) {
      case '?':
         displayHelp(); //launches this to see the options again
         break;
      case 'd':
      case 'D':
         displaySudoku(sudokuData); //see the table
         break;
      case 'q':
      case 'Q':
         writeFile(sudokuData); //write to a file
         runAgain = false; //effectively ends the program
         break;
      case 'e':
      case 'E':
         //edits one square picked by the user which must not have
         //a value already and must be a legal move
         editOneSquare(nineBooleans, rowCol, sudokuData);
         break;
      case 's':
      case 'S':
         //shows all the possible values for the spot picked by the user
         showPosVal(nineBooleans, rowCol, sudokuData);
         break;
      case 'f':
      case 'F':
         //The big Tuna
         if (checkStartNumber(sudokuData))
            solveMagicStart9(sudokuData);
         else
            solveMagicStart1(sudokuData);
         cout << endl;
         displaySudoku(sudokuData);
         break;
      default:
         return;
   }
}
