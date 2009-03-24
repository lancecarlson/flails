package flails.request {
  public interface PathBuilder {
    function index():String;
    
    function show(id:Number):String;
    
    function update(id:Number):String;
    
    function create():String;
    
    function destroy(id:Number):String;
  }
}