import processing.core.*;
import gifAnimation.*;
import java.io.FilenameFilter;

int counter;
String spath = sketchPath("/Users/jakeelwes/Media/ArtWork/FinalYear/Synthesizing - Feedback Loop/GenerativeAIFeedbackLoop/web-interface/genImages/");

int fileCount;
int startingNum;

int imgNumber;
int txtNumber;

boolean imgDone = false;

PFont font;
String line = "";


void setup() {

  surface.setResizable(true);

  frameRate(10);
  smooth();
  font = createFont("Courier", 48);
  textFont(font, 20);


  String[] args = {"AILoop"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);

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

}

void settings(){
  // fullScreen(); //2
  size(500, 500);

}

void draw() {

  background(255);
  fill(0);

  typewriteText(txtNumber);


  if (imgDone) {
    imgDone = false;
    txtNumber = (txtNumber + 1) % startingNum;
    // println ("text " + txtNumber);
    counter = 0;
  }

}

void typewriteText(int txtNumber){

  String lines[] = loadStrings(spath + txtNumber + ".txt");
  line = lines[0];

  if (counter < line.length()){
    counter++;
  }
  text(line.substring(0, counter), 0, height/2, width, height/2);
  textAlign(CENTER);
}



public class SecondApplet extends PApplet {

  // Gif gen;
  PImage[] allFrames;

  int counterPause = 0;
  int counter = 0;

  public void settings() {
    // fullScreen();
    size(500, 500);
  }

  public void setup(){
    frameRate(15);
    surface.setResizable(true);
    // String spath = sketchPath("/Users/jakeelwes/Media/ArtWork/FinalYear/Synthesizing - Feedback Loop/GenerativeAIFeedbackLoop/web-interface/genImages/");
    println(spath);
    allFrames = Gif.getPImages(this, spath + imgNumber + ".gif");

  }


  public void draw() {
    background(0);

    counter++;
    counterPause++;

    int length = Math.min(width, height);

    pushMatrix();
    translate((width-length)/2, (height-length)/2);
    if(counterPause < 260) {
      if (counter < 200) {
        image(allFrames[counter], 0, 0, length, length);
      } else {
        if(counterPause == 200){
          imgDone = true;
        }
        image(allFrames[200], 0, 0, length, length);
      }
    } else {
      counterPause = 0;
      counter = 0;
      imgNumber = (imgNumber + 1) % startingNum;
      // println("img " + imgNumber);
      allFrames = Gif.getPImages(this, spath + imgNumber + ".gif");
    }

    popMatrix();
  }

}
