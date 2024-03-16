import java.util.*;

interface Builder {
  
  ObjetFormeJSON build(JSONObject jsonObject);
}

public class JSONShapeAnalyzer implements FormeParser<JSONObject, ObjetFormeJSON> {
  
  private Map<String, Builder> typeMap;
  
  public JSONShapeAnalyzer() {
    this.typeMap = new HashMap<String, Builder>();
    this.typeMap.put("box", new Builder() { 
      public ObjetFormeJSON build(JSONObject jsonObject) { 
        return new FormeRoomJSON(jsonObject); 
      }
    });
    this.typeMap.put("composite", new Builder() { 
      public ObjetFormeJSON build(JSONObject jsonObject) { 
        return new FormeCompositeJSON(jsonObject, parseObjects(jsonObject.getJSONObject("components")));
      }
    });
  }
  
  public void addType(String type, final JSONObject source) {
    this.typeMap.put(type, new Builder() {
      public ObjetFormeJSON build(JSONObject jsonObject) {
        return parseObject(mergeObject(source, jsonObject));
      }
    });
  }
  
  private JSONObject mergeObject(JSONObject obj1, JSONObject obj2) {
    JSONObject merged = new JSONObject();
    Iterator<String> ite1 = obj1.keyIterator();
    Iterator<String> ite2 = obj2.keyIterator();
    while (ite1.hasNext()) {
      String key = ite1.next();
      merged.put(key, obj1.get(key));
    }
    while (ite2.hasNext()) {
      String key = ite2.next();
      if (!key.equals("type")) {
        merged.put(key, obj2.get(key));
      }
    }
    return merged;
  }
  
  @Override
  public ObjetFormeJSON parseObject(JSONObject jsonObject) {
    String type = jsonObject.getString("type");
    return this.typeMap.get(type).build(jsonObject);
  }
  
  @Override
  public ObjetFormeJSON[] parseObjects(JSONObject jsonObjects) {
    int size = jsonObjects.size();
    ObjetFormeJSON[] jsonFormes = new ObjetFormeJSON[size];
    Iterator<String> ite = jsonObjects.keyIterator();
    int i = 0;
    while (ite.hasNext()) {
      JSONObject object = jsonObjects.getJSONObject(ite.next());
      jsonFormes[i++] = parseObject(object);
    }
    return jsonFormes; 
  }
}
