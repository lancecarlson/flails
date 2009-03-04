/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package org.flails.request {
  
  import org.flails.request.Request;
  
  public class Model {
    public var resource:String;
    
    public function Model(resource:String) {
      this.resource = resource;
    }
    
    public function findAll():Request {
      return newRequest().dispatch();
    }
    
    public function findByID(id:uint):Request {
      var request:Request = newRequest();
      request.resourceID = id;
      return request.dispatch();
    }
    
    public function create(attributes:Object):Request {
      var request:Request = newRequest();
      request.method = "POST";
      request.pushParams(attributes);
      return request.dispatch();
    }
    
    public function update(id:uint, attributes:Object):Request {
      var request:Request = newRequest();
      request.resourceID = id;
      request.method = "PUT";
      request.pushParams(attributes);
      return request.dispatch();
    }
    
    public function destroy(id:uint):Request {
      var request:Request = newRequest();
      request.resourceID = id;
      request.method = "DELETE";
      request.pushParams({});
      return request.dispatch();
    }
    
    private function newRequest():Request {
      return new Request(resource);
    }
  }
}