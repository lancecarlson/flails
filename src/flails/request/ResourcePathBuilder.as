/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  import flails.request.PathBuilder;
  public class ResourcePathBuilder implements PathBuilder {
    public var host:String = "";
    private var pluralResource:String;
    private var format:String;
    
    public function ResourcePathBuilder(pluralResource:String, format:String = "json") {
      this.pluralResource = pluralResource;
      this.format = format;
    }
    
    public function index():String {
      return resourcesUrl();
    }
    
    public function show(id:Number):String {
      return resourcesUrl(id.toString());
    }
    
    public function update(id:Number):String {
      return resourcesUrl(id.toString());
    }
    
    public function create():String {
      return resourcesUrl();
    }
    
    public function destroy(id:Number):String {
      return resourcesUrl(id.toString());
    }

    private function resourcesUrl(more:String = null):String {
      var base:String = host + "/" + pluralResource; 

      if (more) {
        return base + "/" + more + "." + format;
      }

      return base + "." + format;
    }
  }
}