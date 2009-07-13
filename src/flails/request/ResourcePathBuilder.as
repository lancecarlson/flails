/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  import flails.request.PathBuilder;
  public class ResourcePathBuilder {
    private var host:String = "";
    private var pluralResource:String;
    private var format:String;
    private var parent:ResourcePathBuilder;
    
    public function ResourcePathBuilder(host:String, pluralResource:String, format:String) {
      this.host           = host;
      this.pluralResource = pluralResource;
      this.format         = format;
    }

    public function index():String {
      return resourcesUrl(null);
    }
    
    public function show(id:Object = null):String {
      return resourcesUrl(id && id.toString());
    }
    
    public function update(id:Object = null):String {
      return resourcesUrl(id && id.toString());
    }
    
    public function create():String {
      return resourcesUrl(null);
    }
    
    public function destroy(id:Object = null):String {
      return resourcesUrl(id.toString());
    }

    private function resourcesUrl(more:Object = null):String {
      if (more) {
        return base() + "/" + more + "." + format;
      }

      return base() + "." + format;
    }

    private function base():String {
      return host + "/" + pluralResource; 
    }
  }
}