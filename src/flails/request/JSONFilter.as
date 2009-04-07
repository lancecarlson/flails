/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  import com.adobe.serialization.json.*;
  import flails.resource.Record;
  import flails.request.Filter;
  
  public class JSONFilter implements Filter {
    public function JSONFilter(targetClass:Class = null) {}
    
    public function load(data:Object):Object {
      return JSON.decode(data as String);
    }

    public function dump(data:Object):Object {
      return null;
    }
  }
}