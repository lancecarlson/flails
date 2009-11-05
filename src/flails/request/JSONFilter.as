/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  import com.adobe.serialization.json.*;
  import flails.resource.Record;
  import flails.request.Filter;
  
  import mx.logging.ILogger;
  import mx.logging.Log;

  public class JSONFilter implements HTTPFilter {
    public static const CONTENT_TYPE:String = "application/json";
    public static const EXTENSION:String = "json";

    private var log:ILogger = Log.getLogger("flails.request.JSONFilter");

    public function JSONFilter() {}
    
    public function get contentType():String {
      return CONTENT_TYPE;
    }

    public function get extension():String {
      return EXTENSION;
    }

    public function load(data:Object):Object {
      try {
        return JSON.decode(data as String);
      } catch (e:JSONParseError) {
        e.message = e.message + ": " + data;
        
        throw e;
      }

      return null;
    }
  }
}
