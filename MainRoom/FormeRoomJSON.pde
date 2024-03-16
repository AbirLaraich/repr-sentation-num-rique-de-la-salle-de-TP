public class FormeRoomJSON extends ObjetFormeJSON {
  
  PShape shape;
  
  public FormeRoomJSON(JSONObject jsonObject) {
    super(jsonObject);
    this.shape = createBox(jsonObject);
  }
  
  @Override
  public void draw() {
    PVector p = getPosition();
    PVector r = getRotation();
    pushMatrix();
      rotateX(r.x);
      rotateY(r.y);
      rotateZ(r.z);
      translate(p.x, p.y, p.z);
      shape(shape);
    popMatrix();
  }

  private PShape createBox(JSONObject data) {
    JSONArray pos = data.getJSONArray("dimensions");
    float x = pos.getFloat(0);
    float y = pos.getFloat(1);
    float z = pos.getFloat(2);
    PShape s = createShape();
    s.beginShape(QUADS);
      s.textureMode(NORMAL);
      s.texture(environment.getTextures()[data.getInt("texture")]);
      s.shininess(200);
      s.emissive(0, 0, 0);
  
      s.normal(0, 0, 1);
      s.vertex(0, 0, z, 0, 0);
      s.vertex(x, 0, z, 1, 0);
      s.vertex(x, y, z, 1, 1);
      s.vertex(0, y, z, 0, 1);
  
      s.normal(0, 0, -1);
      s.vertex(x, 0, 0, 0, 0);
      s.vertex(0, 0, 0, 1, 0);
      s.vertex(0, y, 0, 1, 1);
      s.vertex(x, y, 0, 0, 1);
  
      s.normal(0, 1, 0);
      s.vertex(0, y, z, 0, 0);
      s.vertex(x, y, z, 1, 0);
      s.vertex(x, y, 0, 1, 1);
      s.vertex(0, y, 0, 0, 1);
  
      s.normal(0, -1, 0);
      s.vertex(0, 0, 0, 0, 0);
      s.vertex(x, 0, 0, 1, 0);
      s.vertex(x, 0, z, 1, 1);
      s.vertex(0, 0, z, 0, 1);
  
      s.normal(1, 0, 0);
      s.vertex(x, 0, z, 0, 0);
      s.vertex(x, 0, 0, 1, 0);
      s.vertex(x, y, 0, 1, 1);
      s.vertex(x, y, z, 0, 1);
  
      s.normal(-1, 0, 0);
      s.vertex(0, 0, 0, 0, 0);
      s.vertex(0, 0, z, 1, 0);
      s.vertex(0, y, z, 1, 1);
      s.vertex(0, y, 0, 0, 1);
    s.endShape(CLOSE);
    return s;
  }
}
