Environment environment;
Entry entry;


void setup() {
  size(1000, 700, P3D);
  frameRate(30);
  noStroke();
  environment = new JSONEnv("data.json"); 
  entry = new Entry();
  environment.load();
}

void draw() {
  entry.update();
  environment.draw();
}

float degreeToRadian(float degree) {
  return degree / 180 * PI;
}
