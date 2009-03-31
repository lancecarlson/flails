/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  import com.adobe.serialization.json.*;
  import flails.resource.Record;
  import flails.request.Filter;
  
  public class IdentityFilter implements Filter{
    private var targetClass:Class;
    public function IdentityFilter(targetClass:Class = null) {
      if (targetClass) {
        this.targetClass = targetClass;
      } else {
        this.targetClass = Record;
      }
    }
    
    public function load(data:Object):Object {
      if (data != null) {
        if (data is Array) {
          var result:Array = [];

          for each (var o:Object in data) {
            result.push(new targetClass(o));
          }

          return result;
        } else {
          return new targetClass(data);
        }
      } else {
        return null;
      }
    }

    public function dump(data:Object):Object {
      return null;
    }
  }
}