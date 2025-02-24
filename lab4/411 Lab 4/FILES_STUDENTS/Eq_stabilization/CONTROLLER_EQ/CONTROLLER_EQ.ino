  #define encoder0PinA 7
  #define encoder0PinB 4

  #include "Timer.h"

  // INITIALIZATIONS

  //timer
  Timer t;

  //PARAMETERS
  //Controller sample time
  double T_sample = 50;
  // Discrete A matrix
  double a11 = 1;
  double a12 = 0.0336;
  double a21 = 0;
  double a22 = 0.4246;

  // Discrete B matrix
  double b1 = 0.0024;
  double b2 = 0.0826;

  //Observer states
  double L_1 = 0.7246;
  double L_2 = 0.0915;

  // Controller's gains
  double k1 = 101.6638;
  double k2 = 5.8702;

  // Position Eq in meters
  double x_eq = 0.3;

  //Encoder
  enum PinAssignments {
  encoderPinA = 2,
  encoderPinB = 3,
  };
  volatile int encoderPos = 0;
  int lastReportedPos = 1;
  boolean A_set = false;
  boolean B_set = false;
  // encoder clicks to position constant
  double K_encoder = 2.2749*0.00001;

  //Motor
  int PWM_A   = 11;
  int DIR_A   = 8;

  //General

  //Data trasnfer rate
  int Tplot = 50;
  // index for saving the observer output
  int index =1;
  //Total elapsed time
  double T_tot = 0;
  // Experiment Time
  int T_exp = 15000;


  //Motor Command

  //Motor computed duty cycle
  int Duty_cycle; 
  //Initial controller's value
  double u =0;

  //Observer initial states
  double x_old_1 = 0.0;
  double x_new_1 = 0.0;
  double x_old_2 = 0;
  double x_new_2 = 0;
  


  void setup() {

  //Encoder
  
  pinMode(encoderPinA, INPUT); 
  pinMode(encoderPinB, INPUT); 
  digitalWrite(encoderPinA, HIGH);  // turn on pullup resistor
  digitalWrite(encoderPinB, HIGH);  // turn on pullup resistor
  attachInterrupt(0, doEncoderA, CHANGE);
  attachInterrupt(1, doEncoderB, CHANGE);
  
  
  Serial.begin (9600);
  
 // Motor pins
  pinMode(PWM_A, OUTPUT);
  pinMode(DIR_A, OUTPUT); 
  
  // clock setup
  
  TCCR1A = _BV(COM1A1) | _BV(WGM21) | _BV(WGM20);
  TCCR1B = _BV(CS10);
  OCR1A = 0;// up to 1024 PIN 9
  
 
  
  // Perform takeReading every T_sample ms
  t.every(T_sample,takeReading);
  // Perform Plot every Tplot ms
  t.every(Tplot,Plot);
  // Perform doAfter after T_exp ms
  t.after(T_exp, doAfter);
  
}


  void loop(){ 
  // Update the direction of motor based on the sign of Duty_cycle  
  
  if (Duty_cycle>0){
    
    digitalWrite(DIR_A,HIGH);
    OCR1A = Duty_cycle;
       
  }
 
  if (Duty_cycle<=0){
    
    digitalWrite(DIR_A,LOW);
    OCR1A = -Duty_cycle ;
       
  }
 
  // Update timer
  t.update();
  }




  // control input computation
  void takeReading(){
  
  // Total Time update   
  T_tot = T_tot+T_sample/1000;   
 
  // CONTROLLER
 // u = 10;
  u = -k1*(x_old_1 - x_eq) - k2*x_old_2;   
   
  // OBSERVER
  x_new_1 = a11*x_old_1 + a12*x_old_2 + b1*u - L_1*x_old_1 + L_1*encoderPos*K_encoder;
  x_new_2 = a21*x_old_1 + a22*x_old_2 + b2*u - L_2*x_old_1 + L_2*encoderPos*K_encoder;
 
 
  // Control input to motor's duty cycle  
  Duty_cycle = round(u/11.75*1024);
    
  index++; 
    
  if (Duty_cycle>512){
      Duty_cycle=512;
   }
    
  if (Duty_cycle<-512){
  Duty_cycle=-512;
  }
    
  // Update old states of the observer
  x_old_1 = x_new_1;
  x_old_2 = x_new_2;  
      
  }  


  void doAfter(){  
  // Send the observer states to the computer
  OCR1A = 0;
 
  delay(6000000);
  }


  void Plot(){
  Serial.println(encoderPos);
  Serial.println(x_new_1*1000);

Serial.println(x_new_2*1000);
  }

  // Interrupt on A changing state
  void doEncoderA(){
  // Test transition
  A_set = digitalRead(encoderPinA) == HIGH;
  // and adjust counter + if A leads B
  encoderPos += (A_set != B_set) ? +1 : -1;
  }

  // Interrupt on B changing state
  void doEncoderB(){
  // Test transition
  B_set = digitalRead(encoderPinB) == HIGH;
  // and adjust counter + if B follows A
  encoderPos += (A_set == B_set) ? +1 : -1;
  }
