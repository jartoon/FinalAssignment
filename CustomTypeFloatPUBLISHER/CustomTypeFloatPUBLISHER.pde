//Custom Type Demo:  float
//FOR INPUT (Publisher)

import spacebrew.*;

Spacebrew sb;




void setup(){
  size(800, 600);

  sb = new Spacebrew(this);
  
  sb.addPublish("noise", "float", "");
  
  sb.connect("sandbox.spacebrew.cc", "Jarrett Noise", "");
}



void draw(){
  float n = noise(millis() * .001);
  sb.send("noise", "float", str(n));
  

}

void onCustomMessage(String name, String type, String value){
  
  
  
}