public class FormeCompositeJSON extends ObjetFormeJSON {
  
  private ObjetFormeJSON[] components;
  
  public FormeCompositeJSON(JSONObject jsonObject, ObjetFormeJSON[] components) {
    super(jsonObject);
    this.components = components;
  }
  
  @Override
  public void draw() {
    PVector p = getPosition();
    PVector r = getRotation();
    pushMatrix();
      translate(p.x, p.y, p.z);
      rotateX(r.x);
      rotateY(r.y);
      rotateZ(r.z);
      for (int i = 0; i < components.length; i++) {
        components[i].draw();
      }
    popMatrix();
  }
}  
