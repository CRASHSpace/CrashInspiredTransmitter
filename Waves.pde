class Waves extends Routine {

  int NUMBER_OF_WAVES = 10;
  Wave[] waves;

  void setup(PApplet parent) {
    super.setup(parent);
    if (NUMBER_OF_WAVES > 0) {
      waves = new Wave[NUMBER_OF_WAVES];
      for (int i=0; i<NUMBER_OF_WAVES; i++) {
        waves[i] = new Wave();
      }
    }
  }

  void draw() {
    background(0);
    for (int i=0; i<NUMBER_OF_WAVES; i++) {
      waves[i].draw();
    }

    long frame = frameCount - modeFrameStart;
    if (frame > frameRate*TYPICAL_MODE_TIME) {
      for (int i=0; i<NUMBER_OF_WAVES; i++) {
        waves[i].init();
      }

      newMode();
    }
  }
}


class Wave {
  private float a;
  private float f;
  private float r;
  private int y;
  private boolean t;
  private float s;

  PGraphics g;

  color c;

  public Wave() {
    init();

    g = createGraphics(displayWidth, displayHeight, P2D);
  }

  public void init() {
    r = random(TWO_PI);
    f = 2*PI/40.0;
    a = displayWidth/6.0 + random(displayWidth/4.0);
    y = int(displayWidth/16.0) + int(random(displayWidth - displayWidth/16.0));
    s = PI/128.0 - random(PI/16.0);

    if (random(10)<5) {
      s = -s;
    }
    if (true) {
      c = color(random(varMax[0]), random(varMax[1]), random(varMax[2]));
    }
    else {
      // naim hack (PORNJ Pink: RGB 252/23/218)
      if (random(0, 2) > 1) {
        // pink
        c = color(int(random(220, 255)), int(random(0, 55)), int(random(210, 230)));
      }
      else {
        // orange
        c = color(int(random(230, 255)), int(random(160, 180)), int(random(0, 1)));
      }
    }
  }

  public void draw() {
    float step;
    float h;

    r = r + s;
    if (r > TWO_PI) r = r - TWO_PI;

    step = r;

    g.beginDraw();
    g.background(0);

    float bright_mult = 0.5 + (1+sin(step))/4.0;

    g.stroke(color(red(c)*bright_mult, green(c)*bright_mult, blue(c)*bright_mult));

    for (int x=0; x<displayHeight; x++) {
      h = sin(step) * a;
      step = step + f;
      g.line(y+h*.1, x, y+h*random(1, 1.2), x);
    }

    g.endDraw();

    blend(g, 0, 0, displayWidth, displayHeight, 0, 0, displayWidth, displayHeight, SCREEN);
  }
}

