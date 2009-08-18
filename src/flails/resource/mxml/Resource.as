/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
package flails.resource.mxml {
  import flash.utils.Proxy;
  import flash.utils.flash_proxy;
  import flash.errors.IllegalOperationError;

  import flails.resource.AbstractResource;
  import flails.request.Result;
  import flails.resource.IResource;
  import flails.resource.RailsResource;
  import flails.resource.JavaScriptResource;

  import mx.core.IMXMLObject;

  dynamic public class Resource extends Proxy implements IMXMLObject, IResource {
    public var type:String;
    public var resource:IResource;

    private var _config:Object = new Object;
    private var parent:Object;
    private var id:String;

    public function initialized(parent:Object, id:String):void {
      this.parent = parent;
      this.id     = id;

      if (type == 'rails') {
        resource = new RailsResource(_config);
      } else if (type == "javascript") {
        resource = new JavaScriptResource(_config);
      } else {
        throw new IllegalOperationError("Unknown resource type '" + type + "'");
      }
    }

    public function get config():Object {
      return _config;
    }

    override flash_proxy function setProperty(name:*, value:*):void {
      _config[name] = value;
    }

    override flash_proxy function getProperty(name:*):* {
      return _config[name];
    }

    public function index(data:Object = null):Result {
      return resource.index(data);
    }

    public function show(id:Object = null, data:Object = null):Result {
      return resource.show(id, data);
    }

    public function create(data:Object = null):Result {
      return resource.create(data);
    }

    public function update(id:Object = null, data:Object = null):Result {
      return resource.update(id, data);
    }

    public function destroy(id:Object, data:Object = null):Result {
      return resource.destroy(id, data);
    }
  }
}