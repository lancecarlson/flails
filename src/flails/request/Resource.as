/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package flails.request {
  import flails.request.Request;
  import flails.request.HTTPRequest;
  import flails.request.Record;
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
    
    public function finder():Request {
      return request();
    }
    
    public function creator():Request {
      return request();
    }
    
    public function updater():Request {
      return request();
    }
    
    public function destroyer():Request {
      return request();
    }
    
    private function request():Request {
      return new HTTPRequest(resourceName);
    }
  }
}