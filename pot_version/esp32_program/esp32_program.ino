// include the ResponsiveAnalogRead library
#include <ResponsiveAnalogRead.h>
#include <Button2.h>

#define N_POTS    3
#define N_BUTTONS 3

// define the pin you want to use
const int POT_PIN[] = { 35, 32, 33 };
const int BUTTON_PIN[] = { 12, 14, 27 };


//ResponsiveAnalogRead analog(ANALOG_PIN, true);
ResponsiveAnalogRead *analog[N_POTS];
Button2 *button[N_BUTTONS];


// the next optional argument is snapMultiplier, which is set to 0.01 by default
// you can pass it a value from 0 to 1 that controls the amount of easing
// increase this to lessen the amount of easing (such as 0.1) and make the responsive values more responsive
// but doing so may cause more noise to seep through if sleep is not enabled

void setup() {
  Serial.begin(115200);

  for (int i=0; i < N_POTS; i++) {
    analog[i] = new ResponsiveAnalogRead(POT_PIN[i], true);
    analog[i]->setAnalogResolution(4096);
    analog[i]->setActivityThreshold(32.0);   
  }

  for (int j=0; j < N_BUTTONS; j++) {
    button[j] = new Button2();
    button[j]->begin(BUTTON_PIN[j]);
    button[j]->setPressedHandler(pressed);
    button[j]->setReleasedHandler(released);
  }
}

void loop() {
  for (int j=0; j < N_BUTTONS; j++) {
    button[j]->loop();
  }
  
  for (int i=0; i < N_POTS; i++) {
    analog[i]->update(); 
    
    if(analog[i]->hasChanged()) {
    
      float value = (float)(analog[i]->getValue() >> 2);
      Serial.print("/pot_");
      Serial.print(i);
      Serial.print(" ");
      Serial.println(value / 1024);
    } 
  }
  
  
  //Serial.println("");
  delay(50);
}

void pressed(Button2& btn) {
    int but = 10;
    
    for (int i=0; i < N_BUTTONS; i++) {
      if (btn == *button[i]) {
        but = i;
      }
    }

    send_msg(but, 1);
}

void released(Button2& btn) {
    //Serial.print("released: ");
    //Serial.println(btn.wasPressedFor());
    int but = 10;
    
    for (int i=0; i < N_BUTTONS; i++) {
      if (btn == *button[i]) {
        but = i;
      }
    }
    
    send_msg(but, 0);
}

void send_msg(int n_button, int value) {
    Serial.print("/button_");
    Serial.print(n_button);
    Serial.print(" ");
    Serial.println(value);  
}
