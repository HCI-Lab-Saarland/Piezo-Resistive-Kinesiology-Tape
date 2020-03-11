int horizPin1 = 3;
int horizPin2 = 4;
int vertPin1 = 11;
int vertPin2 = 12;

void setup() {
// put your setup code here, to run once:
Serial.begin(9600);

// input pin
pinMode(A0, INPUT);

// supply pin
pinMode(horizPin1, INPUT);
pinMode(vertPin1, INPUT);
pinMode(horizPin2, INPUT);
pinMode(vertPin2, INPUT);
}

void loop() {
// put your main code here, to run repeatedly:
// measure and write X
pinMode(horizPin1, OUTPUT);
pinMode(horizPin2, OUTPUT);
digitalWrite(horizPin1, HIGH);
digitalWrite(horizPin2, LOW);
Serial.print(analogRead(A0));
digitalWrite(horizPin1, LOW);
pinMode(horizPin1, INPUT);
pinMode(horizPin2, INPUT);

Serial.print(',');

// measure and write Y
pinMode(vertPin1, OUTPUT);
pinMode(vertPin2, OUTPUT);
digitalWrite(vertPin1, HIGH);
digitalWrite(vertPin2, LOW);
Serial.println(analogRead(A0));
digitalWrite(vertPin1, LOW);
pinMode(vertPin1, INPUT);
pinMode(vertPin2, INPUT);
}
