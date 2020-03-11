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


int minValPress = 280, maxValPress = 380; // used for the mapping input values
int cx = wwindow/2, cy = hwindow/2;
int radius = wwindow/3;
float press;
float filteredPress;
float oldPress = 0;
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

  //if (connectionEstablished) { //the things below only happen if we know we have a working connection

    noStroke();
    fill(blue); // blue
    rect(0, 0, width, height); // background
    
    int mean = 0;
    int diff = 0;
    int s;
    
    fill(lightgray);
    ellipse(cx, cy, radius, radius);
    s = incomingValues.size();
    if(s == 0) { return; }
    for(int i = 0; i < s; i++) {
      mean += incomingValues.get(i);
      if(i > 0) { diff += abs(incomingValues.get(i-1) - incomingValues.get(i)); }
    }
    if(diff > 200) { return; }
    mean /= s;
    press = int(map(mean, maxValPress, minValPress, 0, radius));
    filteredPress = (press*k)+(oldPress*(1-k));
    oldPress = filteredPress;
    fill(red);
    if(mean > maxValPress) { filteredPress = 0; }
    ellipse(cx, cy, filteredPress, filteredPress);
}
