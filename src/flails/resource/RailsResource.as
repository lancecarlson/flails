/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
package flails.resource {
  import flash.events.EventDispatcher;

  import flails.clients.HTTPClientBase;
  import flails.clients.RailsClient;
  import flails.clients.ResourceClient;
  import flails.request.HTTPFilter;
  import flails.request.JSONFilter;
  import flails.request.RequestConfig;
  import flails.request.Result;

  import mx.utils.ObjectUtil;

  public class RailsResource implements IResource {
    public var requestConfig:RequestConfig;

    private var filter:HTTPFilter;
    private var config:Object;

    public function RailsResource(config:Object) {
      this.config = config;
      filter      = new JSONFilter();
    }
    
    public function index(data:Object = null):Result {
      return new RailsClient(collection('index'), HTTPClientBase.METHOD_GET, filter).send(requestData(data));
    }

    public function show(id:Object = null, data:Object = null):Result {
      return new RailsClient(member('show', id), HTTPClientBase.METHOD_GET, filter).send(requestData(data));
    }

    public function create(data:Object = null):Result {
      return new RailsClient(collection('create'), HTTPClientBase.METHOD_POST, filter).send(requestData(data));
    }

    public function update(id:Object = null, data:Object = null):Result {
      return new RailsClient(member('update', id), HTTPClientBase.METHOD_PUT, filter).send(requestData(data));
    }

    public function destroy(id:Object, data:Object = null):Result {
      return new RailsClient(member('destroy', id), HTTPClientBase.METHOD_DELETE, filter).send(requestData(data));
    }

    private function collection(method:String):String {
      return config.baseURL + 
        "/" + config.name + 
        (method == "index" || method == "create" ? "" : "/" + method) + 
        (filter.extension != null ? "" : "." + filter.extension);
    }

    private function member(method:String, id:Object):String {
      return config.baseURL + 
        "/" + config.name + 
        (id != null ? "/" + id : "") +
        (method == "show" || method == "update" || method == "destroy" ? "" : "/" + method) + 
        (filter.extension != null ? "" : "." + filter.extension);
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