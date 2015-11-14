class ColorTest extends Routine {
  int animationStep = 0;
  int frameCnt = 0;
  int lineSpacing = 16;
  int lineSlope = 2;
  float r = 255;
  float g = 0;
  float b = 0;

  void draw() {
    background(0);

    long frame = frameCount - modeFrameStart;
    for (int i=0; i<(displayHeight+lineSlope); i++) {
      if (animationStep == i%lineSpacing) {
        //println("color:"+int(r)+","+int(g)+","+int(b));
        /*switch(i) {
        case 0:
          stroke(color(255, 0, 0));
          break;

        case 1:
          stroke(color(0, 255, 0));
          break;

        case 2:
          stroke(color(0, 0, 255));
          break;

        case 3:
          stroke(color(32, 0, 0));
          break;

        case 4:
          stroke(color(0, 32, 0));
          break;

        case 5:
          stroke(color(0, 0, 32));
          break;

        case 6:
          stroke(color(128, 128, 0));
          break;

        case 7:
          stroke(color(0, 128, 128));
          break;

        case 8:
          stroke(color(128, 128, 128));
          break;
        }*/
        stroke(color(r, g, b));
        line(0, i, displayWidth, i-lineSlope);
      }
    }
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }

    frameCnt++;

    if (0 == frameCnt%4) {
      animationStep = (animationStep + 1)%lineSpacing;
    }
    if (0 == frameCnt%(64*4)) {
      if (r>0) {
        r = 0;
        g = 255;
        b = 0;
      } else if (g>0) {
        r = 0;
        g = 0;
        b = 255;
      } else {
        r = 255;
        g = 0;
        b = 0;
      }
      frameCnt = 0;
    }
  }
}