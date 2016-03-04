//THIS uses bit.ly/sbslider to change color of sketch

import spacebrew.*;

import processing.serial.*;

import processing.sound.*;

SoundFile song1;

Serial myPort;

String server="sandbox.spacebrew.cc";
String name="Jarrett Range";
String description ="";
Spacebrew sb;

float radius = 0;

void setup(){
  size(800,600);
  
  // instantiate the sb variable
  sb = new Spacebrew( this);
  
  song1 = new SoundFile(this, "huarache.mp3");
  
  //3 sliders for R G and B
  sb.addSubscribe("r", "range" );
  sb.addSubscribe("g", "range" );
  sb.addSubscribe("b", "range" );
  
   sb.addSubscribe("x1", "range" );
   sb.addSubscribe("y1", "range" );
   
   sb.addSubscribe("posX", "range" );
   sb.addSubscribe("posY", "range" );
   
   sb.addSubscribe("circle", "float");
  
  sb.connect(server, name, description);
  
    println(Serial.list());
    String portName = Serial.list()[3];
    myPort = new Serial(this, portName, 9600);
    
    song1.loop();
}

void serialEvent (Serial myPort) {
  // get the byte:
  int inByte = myPort.read();
  // print it:
  println(inByte);
  
    posX = inByte*2;
  
  song1.amp(map(inByte, 0, 160, 0.0, 1.0)); 
  

}



int r = 0;
int g = 0;
int b = 0;

int locX1 = 150;
int locY1 = 150;

int posX = 300;
int posY = 300;


void draw(){
  
  
  background(r,g,b);
  
  fill(b,g,r);
  stroke(255, 255, 255);
  rectMode(CENTER);
  ellipse(posX, posY, radius, radius);
  ellipse(radius, radius, posX, posY);
  
  
    
}

void onRangeMessage( String name, int value){
  
  //myColor = value; //This will not map it from 0-255 on the slider
  if(name.equals("r")){
  r = (int) map(value, 0, 1023, 0, 255); }//this maps it to 0-255
  else if(name.equals("g")){
  g = (int) map(value, 0, 1023, 0, 255);
  }
  else if(name.equals("b")){
    b = (int) map(value, 0, 1023, 0, 255);
  }
  else if(name.equals("x1")){
    locX1 = (int) map(value, 0, 1023, 0, width);
  }
  else if(name.equals("y1")){
    locY1 = (int) map(value, 0, 1023, 0, height);
  }
  else if(name.equals("posX")){
    posX = (int) map(value, 0, 1023, 0, width);
  }
  else if(name.equals("posY")){
    posY = (int) map(value, 0, 1023, 0, height);
  }

}

void onCustomMessage(String name, String type, String value){
  
  if(name.equals("circle") && type.equals("float")){
    radius = float(value) * width/2;
  }
  
}


  