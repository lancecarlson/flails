/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package org.flails.request {
  
  import com.adobe.serialization.json.*;
  import flash.events.*;
  import org.flails.request.DataObject;
  
  public class JSONService {
    private var data:String;
    private var decoded:*;
    
    public function JSONService(data:String) {
      this.data = data;
      this.decoded = JSON.decode(this.data);
    }
    
    public function getFirst():DataObject {
      return serializeObject(this.decoded[0], 0, this.decoded);
    }
    
    public function getList():* {
      return this.decoded.reverse().map(serializeObject, this);
    }
    
    public function serializeObject(object:Object, index:int, array:Array):DataObject {
      return DataObject.create(object);
    }
  }
}