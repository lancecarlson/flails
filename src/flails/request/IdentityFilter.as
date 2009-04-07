/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  import flails.resource.Record;
  import flails.request.Filter;
  
  public class IdentityFilter implements Filter{
    private var targetClass:Class;
    public function IdentityFilter(targetClass:Class = null) {
    }
    
    public function load(data:Object):Object {
      return data;
    }

    public function dump(data:Object):Object {
      return null;
    }
  }
}