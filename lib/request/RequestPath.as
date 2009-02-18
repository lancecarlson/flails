package lib.request {
  public class RequestPath {
    public var host:String = "http://localhost:3000";
    private var resource:String;
    private var action:String;
    private var id:uint;
    
    public function RequestPath(resource:String, action:*=null, id:*=0) {
      this.resource = resource;
      this.action = action;
      this.id = id;
    }
    
    public function fullPath():String {
      var path:String = host + "/" + this.pluralizedResource();
      if (action != null) { path += "/" + action };
      if (id != 0) { path += "/" + id };
      return path;
    }
    
    public function pluralizedResource():String {
      return this.resource + "s";
    }
    
  }
}