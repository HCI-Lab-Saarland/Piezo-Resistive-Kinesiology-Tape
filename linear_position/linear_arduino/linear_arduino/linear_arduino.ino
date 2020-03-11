int outputPin = 3;

void setup() {
  Serial.begin(9600);
  pinMode(A0, INPUT);
  pinMode(outputPin, OUTPUT);
  digitalWrite(outputPin, HIGH);
}

void loop() {
  Serial.println(analogRead(A0));
}
