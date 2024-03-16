public class Camera {
  
  private PVector position = new PVector();
  private PVector direction = new PVector();
  private float phi, theta;
  private float speed = 6;
  
  public Camera(float posX, float posY, float posZ, float theta, float phi, float speed) {
      this.position = new PVector(posX, posY, posZ);
      this.direction = new PVector(0, 0, 0);
      this.phi = this.theta = 0;
      this.speed = speed;
      setDirection(theta, phi);
  }
  
  public PVector getPosition() {
    return this.position.copy();  
  }
  
  public PVector getDirection() {
    return this.direction.copy(); 
  }
  
  public float getPhi() {
    return this.phi;
  }
  
  public float getTheta() {
    return this.theta;  
  }
  
  public float getSpeed() {
    return this.speed;
  }
  
  public void setPosition(float x, float y, float z) {
    this.position.x = x;
    this.position.y = y;
    this.position.z = z;
  }
  
  public void setDirection(float theta, float phi) {
    this.direction.x = sin(theta);
    this.direction.y = sin(phi);
    this.direction.z = cos(theta);
    this.direction.normalize();
    this.theta = theta;
    this.phi = phi;
  }
  
  public void setSpeed(float speed) {
    this.speed = speed;
  }
  
  public void moveForward() {
    PVector d = this.direction;
    this.position.add(new PVector(d.x, 0, d.z).normalize().mult(this.speed));
  }
  
  public void moveBackward() {
    PVector d = this.direction;
    this.position.add(new PVector(-d.x, 0, -d.z).normalize().mult(this.speed));
  }
  
  public void moveLeft() {
    PVector d = this.direction;
    this.position.add(new PVector(d.z, 0, -d.x).normalize().mult(this.speed));
  }
  
  public void moveRight() {
    PVector d = this.direction;
    this.position.add(new PVector(-d.z, 0, d.x).normalize().mult(this.speed));
  }
  
  public void moveUp() {
    this.position.y -= this.speed; 
  }
  
  public void moveDown() {
    this.position.y += this.speed; 
  }
  
  void apply() {
    PVector p = this.position;
    PVector d = this.direction;
    camera(p.x, p.y, p.z, p.x + d.x, p.y + d.y, p.z + d.z, 0, 1, 0);
  }
}
