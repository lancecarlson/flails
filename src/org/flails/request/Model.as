package org.flails.request {
  
  import org.flails.request.Request;
  
  public class Model {
    public var resource:String;
    private var request:Request;
    
    public function Model(resource:String) {
      this.resource = resource;
      this.request = new Request(resource);
    }
    
    public function findAll():Request {
      return this.request.dispatch();
    }
    
    public function findByID(id:uint):Request {
      this.request.resourceID = id;
      return this.request.dispatch();
    }
  }
}