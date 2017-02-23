import processing.core.*;
import gifAnimation.*;
import java.io.FilenameFilter;

int counterA;
String spath = sketchPath("/Users/jakeelwes/Media/ArtWork/FinalYear/Synthesizing - Feedback Loop/GenerativeAIFeedbackLoop/web-interface/genImages/");

int fileCount;
int startingNum;

int imgNumber;
int txtNumber;
int length;

boolean imgDone = false;

PFont font;
String line = "";

PImage[] allFrames;

int counterPause = 0;
int counter = 0;

int padding = 20;
int squareSize;



void setup() {

  surface.setResizable(true);

  frameRate(10);
  smooth();
  font = createFont("Courier", 48);
  textFont(font, 28);

  File imageDir = new File(spath);
  FilenameFilter ff = new FilenameFilter() {
    public boolean accept(File imageDir, String name) {
       return name.endsWith(".gif");
        }
      };
   String[] theList = imageDir.list(ff);
  fileCount = theList.length;
   println(str(fileCount) + " image files");

   startingNum = (int) random(fileCount);
   // startingNum = 161;
   imgNumber = startingNum;
   txtNumber = startingNum;

   frameRate(15);
   surface.setResizable(true);
   // String spath = sketchPath("/Users/jakeelwes/Media/ArtWork/FinalYear/Synthesizing - Feedback Loop/GenerativeAIFeedbackLoop/web-interface/genImages/");
   println(spath);
   allFrames = Gif.getPImages(this, spath + imgNumber + ".gif");

   background(0);


}

void settings(){
  // fullScreen(); //2

  size(500, 800);

}

void draw() {

  // if(swap){
  //   rotate(HALF_PI);
  //   translate(0,-width);
  // }

  fill(255);

  squareSize = height/2 - 2*padding;

  // background(0);

  counter++;
  counterPause++;

  length = Math.min(width, height);

  // pushMatrix();
  // translate((width-length)/2, (height-length)/2);

  int border = length/8;

  if(counterPause < 260) {
    if (counter < 200) {
      tint(255, 80);
      image(allFrames[counter], (width-squareSize)/2, padding, squareSize, squareSize);
    } else {
      if(counterPause == 200){
        imgDone = true;
      }
      image(allFrames[200], (width-squareSize)/2, padding, squareSize, squareSize);
    }
  } else {
    counterPause = 0;
    counter = 0;
    imgNumber = (imgNumber + 1) % fileCount;
    // println("img " + imgNumber);
    allFrames = Gif.getPImages(this, spath + imgNumber + ".gif");
  }


  fill(0);
  rect((width-squareSize)/2 , height/2+padding/2, squareSize, squareSize);
  fill(255);
  typewriteText(txtNumber);


  if (imgDone) {
    imgDone = false;
    txtNumber = (txtNumber + 1) % fileCount;
    // println ("text " + txtNumber);
    counterA = 0;
  }
  // popMatrix();

  // rect(padding, (height-squareSize)/2, squareSize, squareSize);


}


void typewriteText(int txtNumber){

  String lines[] = loadStrings(spath + txtNumber + ".txt");
  line = lines[0];

  if (counterA < line.length()){
    counterA++;
  }

  text(line.substring(0, counterA), (width-squareSize)/2 , height/2+padding/2, squareSize, squareSize);
  textAlign(CENTER, CENTER);


}
