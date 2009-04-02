/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
 
package flails.request {
  public class ResourceJavaScriptBuilder implements PathBuilder {
    private var pluralResource:String;
    
    public function ResourceJavaScriptBuilder(pluralResource:String) {
      this.pluralResource = pluralResource;
    }
    
    public function index():String {
      return pluralResource + "Index";
    }
    
    public function show(id:Object = null):String {
      return pluralResource + "Show";
    }
    
    public function update(id:Object = null):String {
      return pluralResource + "Update";
    }
    
    public function create():String {
      return pluralResource + "Create";
    }
    
    public function destroy(id:Object = null):String {
      return pluralResource + "Destroy";
    }
  }
}