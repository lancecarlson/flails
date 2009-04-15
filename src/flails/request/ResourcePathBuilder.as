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
    private var parent:ResourcePathBuilder;
    
    public function ResourcePathBuilder(pluralResource:String, format:String = "json", parent:ResourcePathBuilder = null) {
      this.pluralResource = pluralResource;
      this.format = format;
    }

    public function asParent(id:Object = null, parentIds:Array = null):String {
      if (id)
        return base(parentIds) + "/" + id.toString() + "/";

      return base(parentIds) + "/";
    }
    
    public function index(parentIds:Array = null):String {
      return resourcesUrl(null, parentIds);
    }
    
    public function show(id:Object = null, parentIds:Array = null):String {
      return resourcesUrl(id && id.toString(), parentIds);
    }
    
    public function update(id:Object = null, parentIds:Array = null):String {
      return resourcesUrl(id && id.toString(), parentIds);
    }
    
    public function create(parentIds:Array = null):String {
      return resourcesUrl(null, parentIds);
    }
    
    public function destroy(id:Object = null, parentIds:Array = null):String {
      return resourcesUrl(id.toString(), parentIds);
    }

    private function resourcesUrl(more:Object = null, parentIds:Array = null):String {
      var base:String = base(parentIds);

      if (more) {
        return base + "/" + more + "." + format;
      }

      return base + "." + format;
    }

    private function base(parentIds:Array):String {
      if (parent) {
        var parentId:Object = parentIds.shift();

        return parent.asParent(parentId, parentIds) + pluralResource;
      }

      return host + "/" + pluralResource; 
    }
  }
}