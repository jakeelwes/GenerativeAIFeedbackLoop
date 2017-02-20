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
   int fileCount = theList.length;
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

}

void settings(){
  // fullScreen(); //2
  size(1000, 600);

}

void draw() {

  background(0);
  fill(255);

  // background(0);

  counter++;
  counterPause++;

  length = Math.min(width, height);

  // pushMatrix();
  // translate((width-length)/2, (height-length)/2);

  int border = length/8;

  if(counterPause < 260) {
    if (counter < 200) {
      image(allFrames[counter], 0+border, 0+border, length-2*border, length-2*border);
    } else {
      if(counterPause == 200){
        imgDone = true;
      }
      image(allFrames[200], 0+border, 0+border, length-2*border, length-2*border);
    }
  } else {
    counterPause = 0;
    counter = 0;
    imgNumber = (imgNumber + 1) % startingNum;
    // println("img " + imgNumber);
    allFrames = Gif.getPImages(this, spath + imgNumber + ".gif");
  }

  typewriteText(txtNumber);


  if (imgDone) {
    imgDone = false;
    txtNumber = (txtNumber + 1) % startingNum;
    // println ("text " + txtNumber);
    counterA = 0;
  }
  // popMatrix();
}


void typewriteText(int txtNumber){

  String lines[] = loadStrings(spath + txtNumber + ".txt");
  line = lines[0];

  if (counterA < line.length()){
    counterA++;
  }
  if (width<height){
    text(line.substring(0, counterA), 0, length+((height-length)/2), width, length+((height-length)/2));
    textAlign(CENTER);
  } else if (height<width) {
    text(line.substring(0, counterA), length + (width-length)/5  , height/2, width, height);
    textAlign(LEFT);
  }

}
