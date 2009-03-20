/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package org.flails.request {
  import org.flails.request.Request;
  import org.flails.request.Record;
  import flash.utils.getQualifiedClassName;
  
  public class Resource {
    public static function forName(resourceName:String):Resource {
      return new Resource(resourceName, Record);
    }

    public static function forClass(recordClass:Class):Resource {
      return new Resource(getQualifiedClassName(recordClass).split("::")[1].toLowerCase(), recordClass);
    }

    public var resourceName:String;
    public var recordClass:Class;
    
    public function Resource(resourceName:String, recordClass:Class) {
      this.resourceName = resourceName;
      this.recordClass  = recordClass;
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
      return new Request(resourceName);
    }
  }
}