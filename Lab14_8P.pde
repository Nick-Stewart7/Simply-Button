import processing.serial.*;

Serial sensor;
ButtonWithLED[] ba = new ButtonWithLED[2];

int buttonValue = 85;

int w = 64;
int h = 64;
int x1 = 324;
int x2 = x1 + w + w / 2;
int y = 200;

void setup() {
  size(640, 480);
  //printArray(Serial.list());
  //printArray(PFont.list());
  sensor = new Serial(this, Serial.list()[0], 9600);
  ba[0] = new ButtonWithLED(x1, y);
  ba[1] = new ButtonWithLED(x2, y);
  ba[0].setup();
  ba[1].setup();
}

void draw() {
  background(255);
  PFont f = createFont(PFont.list()[3], 48);
  textFont(f);
  fill(0);
  switch (buttonValue) {
    case 85:
      fill(0);
      text("UP", 128, 216);
      break;
    case 68:
      fill(0, 255, 0);
      text("DOWN", 80, 216);
      break;
    default:
      break;
  }
    ba[0].draw();
    ba[1].draw();
}

void serialEvent(Serial s) {
  buttonValue = s.read();
}

void mousePressed() {
  ba[0].mousePressed();
  ba[1].mousePressed();
  int value = (ba[0].led ? 1 : 0) + (2 * (ba[1].led ? 1 : 0)) + '0';
  sensor.write(value);
}
void mouseReleased() {
  ba[0].mouseReleased();
  ba[1].mouseReleased();
}
void mouseMoved() {
  ba[0].mouseMoved();
  ba[1].mouseMoved();
}

boolean mouseInRect1() {
  return sqrt(((x1 - mouseX)*(x1 - mouseX)) + ((y - mouseY)*(y - mouseY))) <= (w/2);
}

boolean mouseInRect2() {
  return sqrt(((x2 - mouseX)*(x2 - mouseX)) + ((y - mouseY)*(y - mouseY))) <= (w/2);
}
