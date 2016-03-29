#include <SoftwareSerial.h>

// pps input: 2
// rx  input: 10

bool first_ = true;
signed long prev_time_ = 0;

SoftwareSerial mySerial(10, 11); // RX,TX

void setup() {
  Serial.begin(57600);
  mySerial.begin(9600);

  attachInterrupt(digitalPinToInterrupt(2), isrPPS, RISING);
}

void loop() {
}

void isrPPS() {
  signed long now = micros();
  if(!first_)
    Serial.println(1000000 - (now - prev_time_));
  first_ = false;
  prev_time_ = now;
}

