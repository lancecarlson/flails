/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
package flails.resource.mxml {
  import flash.events.EventDispatcher;

  import flails.resource.Resource;
  import flails.request.JSONFilter;
  import flails.request.ResourcePathBuilder;
  import flails.clients.RailsClient;
  import flails.clients.HTTPClientBase;
  import flails.clients.ResourceClient;
  import flails.request.HTTPFilter;
  import flails.request.RequestConfig;
  import flails.request.Result;

  import mx.utils.ObjectUtil;

  public class RailsResource extends Resource {
    public var requestConfig:RequestConfig;

    private var filter:HTTPFilter;
    private var pathBuilder:ResourcePathBuilder;
    private var _baseURL:String;
    
    override public function initialized(parent:Object, id:String):void {
      super.initialized(parent, id);

      filter = new JSONFilter();
      
      if (baseURL != null) {
        pathBuilder = new ResourcePathBuilder(baseURL, name, filter.extension);
      }
    }
    
    public function set baseURL(value:String):void {
      _baseURL = value;

      if (value != null) {
        pathBuilder = new ResourcePathBuilder(_baseURL, name, filter.extension);
      }
    }

    public function get baseURL():String {
      return _baseURL;
    }

    override public function index(data:Object = null, completeHandler:Function = null):Result {
      return new RailsClient(pathBuilder.index(), HTTPClientBase.METHOD_GET, filter).send(requestData(data));
    }

    override public function show(id:Object = null, data:Object = null, completeHandler:Function = null):Result {
      return new RailsClient(pathBuilder.show(id), HTTPClientBase.METHOD_GET, filter).send(requestData(data));
    }

    override public function create(data:Object = null, completeHandler:Function = null):Result {
      return new RailsClient(pathBuilder.create(), HTTPClientBase.METHOD_POST, filter).send(requestData(data));
    }

    override public function update(id:Object = null, data:Object = null, completeHandler:Function = null):Result {
      return new RailsClient(pathBuilder.update(id), HTTPClientBase.METHOD_PUT, filter).send(requestData(data));
    }

    override public function destroy(id:Object, data:Object = null, completeHandler:Function = null):Result {
      return new RailsClient(pathBuilder.destroy(id), HTTPClientBase.METHOD_DELETE, filter).send(requestData(data));
    }

    private function requestData(data:Object):Object {
      var out:Object = new Object();

      if (requestConfig) {
        for each (var o:Object in requestConfig.extraParams) {
          out[o.name] = o.value;
        }
      }

      for (var k:Object in data) {
        out[k] = data[k];
      }

      return out;
    }
  }
}