public class ButtonWithLED {
  static final int WIDTH = 64;
  static final int HEIGHT = 64;
  int numFrames = 3;
  int frame = 2;
  PImage[] frames = new PImage[numFrames];
  PImage image;
  int button_x = 0;
  int button_y = 0;
  int button_w = WIDTH;
  int button_h = HEIGHT;
  int led_x = 0;
  int led_y = 0;
  int led_w = button_w / 2;
  int led_h = 20;
  int ledFill = 128;
  boolean led = false;
  public ButtonWithLED(int x, int y) {
    button_x = x - button_w / 2;
    button_y = y - button_h / 2;
  }
  void setup() {
    image = loadImage("button1.png");
    image.loadPixels();
    for (int i = 0; i < numFrames; i++) {
      frames[i] = createImage(
        image.width / numFrames,
        image.height,
        ARGB
      );
      frames[i] = image.get(
        i * image.width / numFrames,
        0,
        image.width / numFrames,
        image.height
      );
    }
    led_x = button_x + button_w / 2 - 1;
    led_y = button_y;
  }
  void draw() {
    stroke(0);
    fill(ledFill, 0, 0);
    rectMode(CENTER);
    rect(led_x, led_y, led_w, led_h, 8);
    image(frames[frame], button_x, button_y, button_w, button_h);
  }
  void mousePressed() {
    if (mouseInRect()) {
      frame = 1;
      led = led ? false : true;
      if (led) {
        ledFill = 255;
      } else {
        ledFill = 128;
      }
    }
  }
  void mouseReleased() {
    if (mouseInRect()) {
      if (frame == 1) {
        frame = 0;
      }
    } else {
      frame = 2;
    }
  }
  void mouseMoved() {
    if (!mouseInRect()) {
      frame = 2;
    } else {
      frame = 0;
    }
  }
  boolean mouseInRect() {
    return (
      (mouseX >= button_x) &&
      (mouseX <= button_x + button_w) &&
      (mouseY >= button_y) &&
      (mouseY <= button_y + button_h)
    );
  }
}
