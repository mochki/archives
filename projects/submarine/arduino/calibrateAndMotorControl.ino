#include <Servo.h>
// Pins to Motors
int FLPin = 6;
int FRPin = 9;
int BLPin = 10;
int BRPin = 11;

// Setting Servos
Servo FL;
Servo FR;
Servo BL;
Servo BR;

void setup()
{
  int speed = 0; // Used in calibration.
  // put your setup code here, to run once:
  FL.attach(FLPin);
  FR.attach(FRPin);
  BL.attach(BLPin);
  BR.attach(BRPin);
  Serial.begin(9600);
  /*
   * Instuctions for calibrating:
   *  1. Plug in Arduino First and wait for some beeping.
   *  2. Click the Reset button on the Arduino and Turn on the Power at the same time.
   */
  Serial.println("Start program sending 180 for 6 seconds");
  speed = 180;
  FL.write(speed);
  FR.write(speed);
  BL.write(speed);
  BR.write(speed);
  delay(6000);

  Serial.println("Now send 0 for 5 seconds");
  speed = 0;
  FL.write(speed);
  FR.write(speed);
  BL.write(speed);
  BR.write(speed);
  delay(5000);

  Serial.println("Now send 90 for 5 seconds");
  speed = 90;
  FL.write(speed);
  FR.write(speed);
  BL.write(speed);
  BR.write(speed);
  delay(5000);
  Serial.println("Calibration finished.");
  // Serial.println("Start program."); // This can be uncommented for skipping calibration
  // speed = 90;
}

void loop() {}

//             | Back | Off | Forward
// Front Left  |  A   |  B  |   C
// Front Right |  D   |  E  |   F
// Back  Left  |  G   |  H  |   I
// Back  Right |  J   |  K  |   L
void serialEvent()
{
  while (Serial.available())
  {
    char CODE = (char)Serial.read();

    switch (CODE)
    {
    /*
     * Front Left
     */
    case 'A':
      Serial.println("Front Left set to 50(Back)");
      FL.write(0);
      break;
    case 'B':
      Serial.println("Front Left set to 90(Stop)");
      FL.write(90);
      break;
    case 'C':
      Serial.println("Front Left set to 130(Go)");
      FL.write(160);
      break;
    /*
     * Front Right
     */
    case 'D':
      Serial.println("Front Right set to 50(Back)");
      FR.write(0);
      break;
    case 'E':
      Serial.println("Front Right set to 90(Stop)");
      FR.write(90);
      break;
    case 'F':
      Serial.println("Front Right set to 130(Go)");
      FR.write(180);
      break;
    /*
     * Back Left
     */
    case 'G':
      Serial.println("Back Left set to 50(Back)");
      BL.write(0);
      break;
    case 'H':
      Serial.println("Back Left set to 90(Stop)");
      BL.write(90);
      break;
    case 'I':
      Serial.println("Back Left set to 130(Go)");
      BL.write(180);
      break;
    case 'J':
      /*
       * Back Right
       */
      Serial.println("Back Right set to 50(Back)");
      BR.write(0);
      break;
    case 'K':
      Serial.println("Back Right set to 90(Stop)");
      BR.write(90);
      break;
    case 'L':
      Serial.println("Back Right set to 130(Go)");
      BR.write(180);
      break;
    }
  }
}
