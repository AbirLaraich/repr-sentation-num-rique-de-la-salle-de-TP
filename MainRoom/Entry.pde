import java.util.*;

public class Entry {
  
  private Map<Integer, Runnable> inputMap;
  private Set<Integer> pressedSet;
  
  public Entry() {
    this.pressedSet = new HashSet<Integer>();
    this.inputMap = new HashMap<Integer, Runnable>();
    this.inputMap.put(68, new Runnable() { public void run() { environment.getCamera().moveRight(); }});
    this.inputMap.put(32, new Runnable() { public void run() { environment.getCamera().moveUp(); }});
    this.inputMap.put(83, new Runnable() { public void run() { environment.getCamera().moveBackward(); }});
    this.inputMap.put(16, new Runnable() { public void run() { environment.getCamera().moveDown(); }});
    this.inputMap.put(90, new Runnable() { public void run() { environment.getCamera().moveForward(); }});
    this.inputMap.put(81, new Runnable() { public void run() { environment.getCamera().moveLeft(); }});
    this.inputMap.put(-999, new Runnable() { public void run() { 
        float max = .08;
        float mx = map(mouseX, 0, width, max, -max);
        float my = map(mouseY, 0, height, -max, max);
        float theta = environment.getCamera().getTheta();
        float phi = environment.getCamera().getPhi();
        theta = (theta + mx) % TWO_PI;
        if (abs(phi + my) < PI / 2) {
          phi += my; 
        }
        environment.getCamera().setDirection(theta, phi);
      }});
  }
  
  public void update() {
    for (Integer keyCode : entry.pressedSet) {
      Runnable r = inputMap.get(keyCode);
      if (r != null) {
        r.run();  
      }
    }
    environment.getCamera().apply();
  }
}

void mousePressed() {
  entry.pressedSet.add(mouseButton == LEFT ? -999 : -998);
}

void mouseReleased() {
  entry.pressedSet.remove(mouseButton == LEFT ? -999 : -998);  
}

void keyPressed() {
  entry.pressedSet.add(keyCode);
}

void keyReleased() {
  entry.pressedSet.remove(keyCode);
}
