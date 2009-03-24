/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package org.flails.request {
  
  import com.adobe.serialization.json.*;
  import flash.events.*;
  import org.flails.request.Record;
  
  public class JSONSerializer {
    private var data:String;
    private var decoded:*;
    
    public function JSONSerializer(data:String) {
      this.data = data;
      this.decoded = JSON.decode(this.data);
    }
    
    public function getFirst():* {
      return serializeObject(this.decoded);
    }
    
    public function getList():* {
      return this.decoded.reverse().map(serializeObject, this);
    }
    
    public function serializeObject(object:Object, index:int=0, array:Array=null):Object {
      var type:String = findType(object);
      var record:Record = new Record(type);
      
      record.setAttributes(object[type]);
      
      return record;
    }
    
    private static function findType(json:Object):String {
      for (var key:String in json) { var type:String = key; }
      return key;
    }
    
  }
}