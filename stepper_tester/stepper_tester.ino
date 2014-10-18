#define STEP_PIN         54
#define DIR_PIN          55
#define ENABLE_PIN       38

#define X_MIN_PIN           3
#define X_MAX_PIN           2


void setup() {
  pinMode(STEP_PIN  , OUTPUT);
  pinMode(DIR_PIN    , OUTPUT);
  pinMode(ENABLE_PIN    , OUTPUT);

   digitalWrite(ENABLE_PIN    , LOW);
}

void loop () {
  if (millis() %10000 <5000) {
    digitalWrite(DIR_PIN    , HIGH);
  }
  else {
    digitalWrite(DIR_PIN    , LOW);
  } 
 
  digitalWrite(STEP_PIN    , HIGH);
  delay(1);
  
  digitalWrite(STEP_PIN    , LOW);
}
