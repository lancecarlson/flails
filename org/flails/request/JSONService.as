package org.flails.request {
  import mx.controls.Alert;
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
    
    public function encode():* {
      return this.decoded.map(serializeObject, this);
    }
    
    public function serializeObject(object:Object, index:int, array:Array):DataObject {
      return DataObject.create(object);
    }
  }
}