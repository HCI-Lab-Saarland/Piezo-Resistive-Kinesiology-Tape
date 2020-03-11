int inputPin = A0;
int pins[] = { 2, 3, 4, 5 }; 
int pn = 4;
int activationThreshold = 1000;

void setup() {
  Serial.begin(9600); // open the serial port at 9600 bps:
  pinMode(inputPin, INPUT);
  for(int pi = 0; pi < pn; pi++) {
    pinMode(pins[pi], OUTPUT);
  }
}

void loop() {
  int activated[4] = { 0, 0, 0, 0 };
  for(int ap = 0; ap < pn; ap++) { // activating ap pin
    digitalWrite(pins[ap], HIGH);
    for(int dp = 0; dp < pn; dp++) { // deactivating dp pins
      if(ap != dp) {
        digitalWrite(pins[dp], LOW);
      }
    }
    activated[ap] = analogRead(inputPin); 
  }

  String res = "";
  for(int ai = 0; ai < pn; ai++) {
    if(ai > 0) { res = res + ","; }
    res = res + String(activated[ai]);
  }
  Serial.println(res);
  delay(20);
}
