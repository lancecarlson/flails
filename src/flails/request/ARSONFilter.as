/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  import com.adobe.serialization.json.*;
  import flails.request.Record;
  import flails.request.Filter;
  
  public class ARSONFilter extends JSONFilter {
    public function JSONFilter(targetClass:Class = null) {
      super(targetClass);
    }
    
    public function load(data:String):Object {
      var decoded:Object = JSON.decode(data);

      if (decoded is Array) {
        var a:Array = [];

        for each(var o:Object in decoded) {
          a.push(new targetClass(o));
        }

        return a;
      } else {
        return new targetClass(decoded);
      }
    }

    public function dump(data:Object):Object {
      return null;
    }
  }
}