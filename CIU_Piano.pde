import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
int tecla = -1, inst = 0;
int afin = 4;
boolean help = false;

Wavetable[] wav = {Waves.SINE, Waves.SQUARE,Waves.SAW,Waves.TRIANGLE,Waves.PHASOR,Waves.QUARTERPULSE};
String [] wavName = {"Sine","Square","Saw","Triangle","Phasor","Quarterpulse"};
String [] notas={
  "C1", "D1", "E1", "F1", "G1", "A1", "B1","C#1", "D#1", "F#1","G#1", "A#1",
  "C2", "D2", "E2", "F2", "G2", "A2", "B2","C#2", "D#2", "F#2","G#2", "A#2",
  "C3", "D3", "E3", "F3", "G3", "A3", "B3","C#3", "D#3", "F#3","G#3", "A#3",
  "C4", "D4", "E4", "F4", "G4", "A4", "B4","C#4", "D#4", "F#4","G#4", "A#4",
  "C5", "D5", "E5", "F5", "G5", "A5", "B5","C#5", "D#5", "F#5","G#5", "A#5",
  "C6", "D6", "E6", "F6", "G6", "A6", "B6","C#6", "D#6", "F#6","G#6", "A#6",
  "C7", "D7", "E7", "F7", "G7", "A7", "B7","C#7", "D#7", "F#7","G#7", "A#7"
};

class ToneInstrument implements Instrument
{
  Oscil wave;
  Line  ampEnv;
  
  ToneInstrument( float frequency, Wavetable wav)
  {
    wave   = new Oscil( frequency, 0, wav );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  void noteOn( float duration )
  {
    ampEnv.activate( duration, 0.4f, 0 );
    wave.patch( out );
  }
  
  void noteOff()
  {
    wave.unpatch( out );
  }
}

void setup()
{
  size(1100, 375);
  minim = new Minim(this);
  out = minim.getLineOut();
}

void draw() {
  background(37,21,11);
  drawPiano(25,150);
  textSize(15);
  text(wavName[inst], 25, 120);
  if(help){
    text("H para ocultar ayuda", 920, 25);
    text("2-6 para cambiar las OCTAVAS", 845, 45);
    text("P para cambiar la forma de la onda", 817, 65);
 }else{
   text("AYUDA (H)", 1000, 25);
 }
  
}

void mousePressed() {
  if(mouseY > 150 && mouseY < 350){
    tecla = (int)((mouseX-25)/50) % 7;
  if(get(mouseX, mouseY) == color(0)){
    if(tecla < 3){
      if((mouseX-25) % 50 > 10){
        tecla += 7;
      }else{
        tecla += 6;
      }
    }else{
    if((mouseX-25) % 50 > 10){
        tecla += 6;
      }else{
        tecla += 5;
      }
    }
  }
  if(mouseX < 375){
    tecla -= 12;
  }
  if (mouseX > 725){
    tecla += 12;
  }
  tecla += 12*(afin-1);
  //println(tecla, tecla - 12*(afin-2));
  out.playNote( 0.0, 0.9, new ToneInstrument( Frequency.ofPitch( notas[tecla] ).asHz(), wav[inst] ) ); 
  }
}

void drawPiano(int x, int y){
  int pos = tecla - 12*(afin-2);
  stroke(0);
  fill(28,13,2);
  rect(x-10,y-10,1070,220);
  fill(255);
  for (int i=0;i<21;i++){
    if(pos < 7){
      if( i == pos){
        fill(150);
      }
    }else if( pos > 11 && pos < 19){
      if( i == pos-5){
        fill(150);
      }
    }else if( pos > 23 && pos < 31){
      if( i == pos-10){
        fill(150);
      }
    }
    rect(i*50+x,y,50,200);
    fill(255);
  }
    fill(0);
  for (int i=0;i<20;i++){
    if(i % 7 != 2 && i % 7 != 6){
      if(pos > 6 && pos < 9){
        if( i == pos-7){
          fill(150);
        }
    }else if(pos > 8 && pos < 12){
        if( i == pos-6){
          fill(150);
        }
    }else if(pos > 18 && pos < 21){
        if( i == pos-12){
          fill(150);
        }
    }else if(pos > 20 && pos < 24){
        if( i == pos-11){
          fill(150);
        }
    }else if(pos > 30 && pos < 33){
        if( i == pos-17){
          fill(150);
        }
    }else if(pos > 32 && pos < 36){
        if( i == pos-16){
          fill(150);
        }
    }
      rect(i*50+40+x,y,20,100);
      fill(0);
    }
  }
  circle(x+25,y+175,25);
  circle(x+375,y+175,25);
  circle(x+725,y+175,25);
  stroke(255);
  fill(255);
  textSize(20);
  text(afin-1,x+20,y+182);
  text(afin,x+370,y+182);
  text(afin+1,x+720,y+182);
}

void mouseReleased(){
  tecla = -1;
}

void keyPressed(){
  if(key == 'H' || key == 'h'){
    help = !help;
  }
  if(key == '2'){
    afin = 2;
  }
  if(key == '3'){
    afin = 3;
  }
  if(key == '4'){
    afin = 4;
  }
  if(key == '5'){
    afin = 5;
  }
  if(key == '6'){
    afin = 6;
  }
  if(key == 'P' || key == 'p'){
    inst += 1;
    if(inst > 5) inst = 0;
  }
}
