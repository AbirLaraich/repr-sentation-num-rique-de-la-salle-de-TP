public interface FormeParser<IN, OUT extends Forme> {
  
  /**
   * Parse a single object of input type to produce a shape.
   * 
   * @param obj The input object to parse.
   * @return The parsed shape.
   */
  OUT parseObject(IN obj);
  
  /**
   * Parse multiple objects of input type to produce an array of shapes.
   * 
   * @param obj The input object to parse.
   * @return An array of parsed shapes.
   */
  OUT[] parseObjects(IN obj);
}
