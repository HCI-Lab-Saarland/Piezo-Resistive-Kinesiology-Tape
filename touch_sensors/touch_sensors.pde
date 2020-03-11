import processing.serial.*; //include the serial library

Serial arduinoPort;  // The serial port at which we listen to data from the Arduino 
String rawIncomingValues; //this is where you dump the content of the serial port
int token = 10; //10 is the linefeed number in ASCII

// window parameters
int wwindow = 1920;
int hwindow = 1080;

// colors
int lightgray = 0x88E2E2E2;
int blue = 0xFF268BD2;
int red = 0xFFD30102;


int xgap = 175;
int mleft = xgap;
int top = 400;
int rwidth = 250, rheight = 250;
int[] thresholds = { 250, 330, 330, 300 }; // need to adapt thresholds to current setup -- touch sensors quite noisy

// we get the values for the four touch sensors
int[] incomingValues = { 0, 0, 0, 0 };

void setup() {
  size(1920, 1080); //sets the size of the output window

  println("these are the available ports: ");
  if(Serial.list().length > 0) {
    printArray(Serial.list());
    String serialPort = Serial.list()[0];
    println("You are using this port: " + serialPort);
    arduinoPort = new Serial(this, serialPort, 9600);
  }
}


void draw() {   
  noStroke();
  fill(blue); // blue
  rect(0, 0, width, height); // background
  
  int x = mleft, y = top;
  // if(incomingValues.size() < 4) { break; }// avoid crash at start
  int count = 0;
  for(int i = 0; i < 4; i++) {
     if(incomingValues[i] > thresholds[i]) { count++; }
  }
  for(int si = 0; si < 4; si++) {
    if(incomingValues[si] > thresholds[si] && count < 2) { // touch sensor activated)
      fill(red); // red
    } else {
      fill(lightgray); // light-gray
    }
    rect(x, y, rwidth, rheight);
    x += rwidth + xgap;
  }
}
