public abstract class ObjetFormeJSON implements Forme {
  
  private PVector position;
  private PVector rotation;
  
  private ObjetFormeJSON(JSONObject jsonObject) {
    JSONArray pos = jsonObject.getJSONArray("position");
    if (pos != null) {
      this.position = new PVector(pos.getFloat(0), pos.getFloat(1), pos.getFloat(2));
    } else {
      this.position = new PVector(0, 0, 0); 
    }
    JSONArray rot = jsonObject.getJSONArray("rotation");
    if (rot != null) {
      this.rotation = new PVector(degreeToRadian(rot.getFloat(0)), degreeToRadian(rot.getFloat(1)), degreeToRadian(rot.getFloat(2)));
    } else {
      this.rotation = new PVector(0, 0, 0); 
    }
  }
  
  public PVector getPosition() {
    return this.position;
  }
  
  public PVector getRotation() {
    return this.rotation;  
  }
}
