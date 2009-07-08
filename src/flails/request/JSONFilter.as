/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  import com.adobe.serialization.json.*;
  import flails.resource.Record;
  import flails.request.Filter;
  
  public class JSONFilter implements HTTPFilter {
    public static const CONTENT_TYPE:String = "application/json";

    public function JSONFilter() {}
    
    public function get contentType():String {
      return CONTENT_TYPE;
    }

    public function load(data:Object):Object {
      return JSON.decode(data as String);
    }
  }
}