import java.util.*;

private interface Loader {
  
  void load();
}

public class JSONEnv implements Environment {
  
  private String fileName;
  private JSONObject root;
  private Map<String, Loader> loaderMap;
  
  private Camera camera;
  private PShader[] shaders;
  private FormeParser shapeParser;
  private Forme[] shapes;
  private PImage[] textures;
  private PVector[] lightPos;
  private PVector[] lightColor;
  
  public JSONEnv(String fileName) {
    this.fileName = fileName;
    this.root = loadJSONObject(fileName);
    this.loaderMap = new LinkedHashMap<String, Loader>();
    this.loaderMap.put("camera", new Loader() { public void load() { loadCamera(); }});
    this.loaderMap.put("textures", new Loader() { public void load() { loadTextures(); }});
    this.loaderMap.put("forms", new Loader() { public void load() { loadShapes(); }});
  }
  
  @Override
  public Camera getCamera() {
    return this.camera;
  }
  
  @Override
  public PShader[] getShaders() {
    return this.shaders;  
  }
  
  @Override
  public Forme[] getShapes() {
    return this.shapes;
  }
  
  @Override
  public PImage[] getTextures() {
    return this.textures;  
  }
  
  @Override
  public PVector[] getLightPos() {
    return this.lightPos; 
  }
  
  @Override
  public PVector[] getLigthColor() {
    return this.lightColor;  
  }
  
  @Override
  public void load() {
    for (Loader loader : this.loaderMap.values()) {
      loader.load();  
    }
  }
  
  public void load(String key) {
    this.loaderMap.get(key).load();    
  }
  
  private void refresh() {
    JSONObject newRoot = loadJSONObject(this.fileName);
    JSONObject oldRoot = this.root;
    this.root = newRoot;
    for (String key : this.loaderMap.keySet()) {
      if (!equalsJSON(newRoot.get(key), oldRoot.get(key))) {
        load(key);
      }
    }
  }
  
  private boolean equalsJSON(Object obj1, Object obj2) {
    if (obj1 == obj2)
      return true;
    if (obj1 instanceof JSONObject)
      return ((JSONObject) obj1).format(0).equals(((JSONObject) obj2).format(0));
    if (obj1 instanceof JSONArray)
      return ((JSONArray) obj1).format(0).equals(((JSONArray) obj2).format(0));
    return false;
  }
  
  @Override
  public void draw() {
    if (frameCount % 2 == 0) {
      refresh();
    }
    background(25);
    for (int i = 0; i < shapes.length; i++) {
       shapes[i].draw(); 
    }
  }
  
  void loadCamera() {
    JSONObject data = this.root.getJSONObject("camera");
    JSONArray pos = data.getJSONArray("position");
    JSONArray angle = data.getJSONArray("angle");
    float speed = data.getFloat("speed");
    camera = new Camera(pos.getFloat(0), pos.getFloat(1), pos.getFloat(2), 
                        degreeToRadian(angle.getFloat(0)), degreeToRadian(angle.getFloat(1)), 
                        speed);
  }
  

  private void loadTextures() {
    JSONArray data = this.root.getJSONArray("textures");
    int size = data.size();
    textures = new PImage[size];
    for (int i = 0; i < size; i++) {
      textures[i] = loadImage(data.getString(i)); 
    }
  }
    
  private void loadShapes() {
    JSONObject data = this.root.getJSONObject("forms");
    JSONObject types = data.getJSONObject("types");
    shapeParser = new JSONShapeAnalyzer();
    Iterator<String> ite = types.keyIterator();
    while (ite.hasNext()) {
      String key = ite.next();
      ((JSONShapeAnalyzer) shapeParser).addType(key, types.getJSONObject(key));
    }
    JSONObject drawable = data.getJSONObject("drawable");
    shapes = shapeParser.parseObjects(drawable);
  }
}
