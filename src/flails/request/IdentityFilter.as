/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  import flails.resource.Record;
  import flails.request.Filter;
  
  public class IdentityFilter implements Filter {
    
    public function load(data:Object):Object {
      return data;
    }
  }
}