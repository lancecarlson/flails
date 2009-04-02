package flails.request {
  public interface PathBuilder {
    function index():String;
    
    function show(id:Object = null):String;
    
    function update(id:Object = null):String;
    
    function create():String;
    
    function destroy(id:Object = null):String;
  }
}