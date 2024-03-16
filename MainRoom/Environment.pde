public interface Environment {
  
  Camera getCamera();
  
  PShader[] getShaders();
  
  Forme[] getShapes();
  
  PImage[] getTextures();
  
  PVector[] getLightPos();
  
  PVector[] getLigthColor();
  
  void load();
  
  void draw();
}
