package flails.request {
  public interface PathBuilder {
    function index(parentIds:Array = null):String;
    
    function show(id:Object = null, parentIds:Array = null):String;
    
    function update(id:Object = null, parentIds:Array = null):String;
    
    function create(parentIds:Array = null):String;
    
    function destroy(id:Object = null, parentIds:Array = null):String;
  }
}