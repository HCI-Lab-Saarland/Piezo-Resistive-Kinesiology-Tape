import processing.serial.*; //include the serial library

Serial arduinoPort;  // The serial port at which we listen to data from the Arduino 
String rawIncomingValues; //this is where you dump the content of the serial port

// window parameters
int wwindow = 1920;
int hwindow = 1080;

// colors
int lightgray = 0x88E2E2E2;
int blue = 0xFF268BD2;
int red = 0xFFD30102;

int minValMotion = 550, maxValMotion = 750; // used for the mapping input values
int cxMotion = wwindow/3, cyMotion = hwindow/2;
int rwMotion = wwindow/3, rhMotion = 100;
int rxMotion = cxMotion, ryMotion = cyMotion - rhMotion/2;
//for filter
float mot;
float filteredMot;
float oldMot = 0;
float k = 0.3;

ArrayList<Integer> incomingValues = new ArrayList<Integer>();

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
  
  int mean = 0;
  int diff = 0;
  int s;
  
  fill(lightgray);
  ellipse(cxMotion, cyMotion, rhMotion, rhMotion);
  mean = 0;
  diff = 0;
  s = incomingValues.size();
  if(s == 0) { return; }
  for(int i = 0; i < s; i++) {
    mean += incomingValues.get(i);
    if(i > 0) { diff += abs(incomingValues.get(i-1) - incomingValues.get(i)); }
  }
  if(diff > 200) { return; }
  mean /= s;
  fill(red);
  translate(cxMotion, cyMotion);
  mot = map(mean, minValMotion, maxValMotion, -PI/8, PI/8);
  filteredMot = (mot*k)+(oldMot*(1-k));
  oldMot = filteredMot;
  rotate(filteredMot);
  fill(red);
  rect(0, -rhMotion/2, rwMotion, rhMotion);
}
