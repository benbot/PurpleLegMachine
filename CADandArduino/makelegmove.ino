//Version 1.0 - We can take input and the leg behaves
//Code for defining leg movement
// with Arduino Uno and Seeed Motor Shield V2.0
// Yung Angelo is on the b-b-beat

#include <SoftwareSerial.h>

//--- Declared variables

int leftmotorForward = 8; // pin 8 --- left motor (+) green wire
int leftmotorBackward = 11; // pin 11 --- left motor (-) black wire
int leftmotorspeed = 9; // pin 9 --- left motor speed signal
int rightmotorForward = 12; // pin 12 --- right motor (+) green wire
int rightmotorBackward = 13; // pin 13 --- right motor (-) black
int rightmotorspeed = 10; // pin 10 --- right motor speed signal

//--- Speeds and Timers
int Think = 2000; //Long delay time between steps
int Runtime = 5000; // How long Runtime actions will last
int Slow = 255; // slow speed (of 255 max)
int Fast = 255; // fast speed (of 255 max)

void setup() { ////---6 Pins being used are outputs--- 
  // We want to setup our serial port to listen for input from the pi
  pinMode(leftmotorForward, OUTPUT);
  pinMode(leftmotorBackward, OUTPUT);
  pinMode(leftmotorspeed, OUTPUT);
  pinMode(rightmotorForward, OUTPUT);
  pinMode(rightmotorBackward, OUTPUT);
  pinMode(rightmotorspeed, OUTPUT);
  
  Serial.begin(9600);
  while(!Serial) {}
  Serial.println("CLOUDSCALE");
  pinMode(36, OUTPUT);
}

int val;
int firstVal, secondVal;
void loop(){ //Get String
  String test;
  if (Serial.available()) {
  test = Serial.readString();
  //char* test = "1retract";
  }

  char* split = "";
   
//Now we do things with firstVal
//All availible motion

   if (test.equalsIgnoreCase("1retract")) {
    goBackwardTop();
   }   else if (test.equalsIgnoreCase("1no")) {
    goForwardTop();
   } 
   else if (test.equalsIgnoreCase("1stop")) {
    StopTop();
   }

   if (test.equalsIgnoreCase("2retract")) {
    goBackwardBottom();
   } else if (test.equalsIgnoreCase("2no")) {
    goForwardBottom();
   } else if (test.equalsIgnoreCase("2stop")) {
    StopBottom();
   }
    

}
  //All of our helper methods
  //----- "Sub-rutine" Voids called by the main loop

void goBackward()

{

analogWrite(leftmotorspeed,Fast); //Enable left motor by setting speed

analogWrite(rightmotorspeed,Fast); //Enable left motor by setting speed

digitalWrite(leftmotorBackward,LOW); // Drives LOW outputs down first to avoid damage

digitalWrite(rightmotorBackward,LOW);

digitalWrite(leftmotorForward,HIGH);

digitalWrite(rightmotorForward,HIGH);

}

void goForward()

{

analogWrite(leftmotorspeed,Slow);

analogWrite(rightmotorspeed,Slow);

digitalWrite(leftmotorForward,LOW);

digitalWrite(rightmotorForward,LOW);

digitalWrite(leftmotorBackward,HIGH);

digitalWrite(rightmotorBackward,HIGH);

}

void goBackwardTop()

{

analogWrite(leftmotorspeed,Fast); //Enable left motor by setting speed

//analogWrite(rightmotorspeed,Fast); //Enable left motor by setting speed

digitalWrite(leftmotorBackward,LOW); // Drives LOW outputs down first to avoid damage

//digitalWrite(rightmotorBackward,LOW);

digitalWrite(leftmotorForward,HIGH);

//digitalWrite(rightmotorForward,HIGH);

}

void goForwardTop()

{

analogWrite(leftmotorspeed,Slow);

//analogWrite(rightmotorspeed,Slow);

digitalWrite(leftmotorForward,LOW);

//digitalWrite(rightmotorForward,LOW);

digitalWrite(leftmotorBackward,HIGH);

//digitalWrite(rightmotorBackward,HIGH);

}

void goBackwardBottom()

{

//analogWrite(leftmotorspeed,Fast); //Enable left motor by setting speed

analogWrite(rightmotorspeed,Fast); //Enable left motor by setting speed

//digitalWrite(leftmotorBackward,LOW); // Drives LOW outputs down first to avoid damage

digitalWrite(rightmotorBackward,LOW);

//digitalWrite(leftmotorForward,HIGH);

digitalWrite(rightmotorForward,HIGH);

}

void goForwardBottom()

{

//analogWrite(leftmotorspeed,Slow);

analogWrite(rightmotorspeed,Slow);

//digitalWrite(leftmotorForward,LOW);

digitalWrite(rightmotorForward,LOW);

//digitalWrite(leftmotorBackward,HIGH);

digitalWrite(rightmotorBackward,HIGH);

}
void StopTop() // Sets speed pins to LOW disabling both motors

{
digitalWrite(leftmotorspeed,LOW);

//digitalWrite(rightmotorspeed,LOW);
}

void StopBottom() {
  digitalWrite(rightmotorspeed, LOW);
}


  


