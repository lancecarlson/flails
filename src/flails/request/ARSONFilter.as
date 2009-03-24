/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  import com.adobe.serialization.json.*;
  import flails.request.Record;
  import flails.request.Filter;
  
  public class ARSONFilter extends JSONFilter {
    private var targetClass:Class;
    public function JSONFilter(targetClass:Class = null) {
      if (targetClass) {
        this.targetClass = targetClass;
      } else {
        this.targetClass = Record;
      }
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
  }
}