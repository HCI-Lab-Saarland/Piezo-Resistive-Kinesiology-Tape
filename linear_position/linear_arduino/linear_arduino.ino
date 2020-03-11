int sensorPin = A0;    // select the input pin for the pressure sensor
int sensorValue = 0;  // variable to store the value coming from the sensor

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);
  // prints the value
  Serial.println(sensorValue);
}
