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



int bkrw2D = 900, bkrh2D = 900;
int bkrx2D = (wwindow - bkrw2D)/2, bkry2D = 75;
int rx2d = bkrx2D, ry2d = bkry2D;
int rw2D = 75, rh2D = 75;
int minVal2Dx = 150, maxVal2Dx = 700;
int minVal2Dy = 150, maxVal2Dy = 700;
// for debugging
int stepx = 5, stepy = 2;
int x2d, y2d;
float fx2d, fy2d;
float oldx2d = minVal2Dx, oldy2d = maxVal2Dy;
float k2d = 0.3;
float k = 0.3;


ArrayList<Integer> incomingValuesX = new ArrayList<Integer>();
ArrayList<Integer> incomingValuesY = new ArrayList<Integer>();


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
    
    int meanX = 0, meanY = 0;
    int diffX = 0, diffY = 0;
    int s;
    
    fill(lightgray);
    rect(bkrx2D, bkry2D, bkrw2D, bkrh2D);
    s = incomingValuesX.size();
    if(s == 0) { return; }
    fill(red);
    for(int i = 0; i < s; i++) {
      meanX += incomingValuesX.get(i);
      meanY += incomingValuesY.get(i);
      if(i > 0) {
        diffX += abs(incomingValuesX.get(i-1) - incomingValuesX.get(i));
        diffY += abs(incomingValuesY.get(i-1) - incomingValuesY.get(i));
      }
    }
    if(diffX > 200 || diffY > 200) { return; }
    meanX /= s; meanY /= s;
    x2d = int(map(meanX, minVal2Dx, maxVal2Dx, bkrx2D, bkrx2D + bkrw2D - rw2D));
    fx2d = (x2d*k)+(oldx2d*(1-k));
    oldx2d = fx2d;
    y2d = int(map(meanY, minVal2Dy, maxVal2Dy, bkry2D, bkry2D + bkrh2D - rh2D));
    fy2d = (y2d*k)+(oldy2d*(1-k));
    oldy2d = fy2d;
    rect(fx2d, fy2d, rw2D, rh2D);
}
