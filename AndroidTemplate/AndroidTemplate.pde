//When running on the iPad or iPhone, you won't see anything unless you tap the screen.
//If it doesn't appear to work first time, always try refreshing the browser.

Maxim maxim;
AudioPlayer player;
float go;
boolean playit;

int elements = 20;// This is the number of points and lines we will calculate at once. 1000 is alot actually. 

void setup() {
  //The size is iPad Portrait.
  //If you want landscape, you should swap the values.
  size(768, 1024); 

  frameRate(25); // this is the framerate. Tweak for performance
  maxim = new Maxim(this);
  player = maxim.loadFile("mybeat.wav");
  player.setLooping(true);
  player.setAnalysing(true);
  noStroke();
  rectMode(CENTER);
  background(0);
  colorMode(HSB);
}

void draw() {

  if (playit) {

    player.play();
    float power = player.getAveragePower();
    //go+=power*50;
    go = power * 50;
    translate(width/2, height/2);// we translate the whole sketch to the centre of the screen, so 0,0 is in the middle.
    for (int i = elements; i > 0;i--) {
      fill((5*i+go)%255, power*512, 255); // this for loop calculates the x and y position for each node in the system and draws a line between it and the next.
      ellipse((mouseX-(width/2))*(elements-i)/elements, (mouseY-(height/2))*(elements-i)/elements, width*1.5/elements*i, height*1.5/elements*i);
    }
    player.speed((float) mouseX / (float) width);
  }
}

void mousePressed() {

  playit = !playit;

  if (playit) {

    player.play();
  } 
  else {

    player.stop();
  }
}

