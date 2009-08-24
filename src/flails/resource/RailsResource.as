/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
package flails.resource {
  import flash.events.EventDispatcher;

  import flails.IdentityMap;
  import flails.clients.HTTPRequestMethod;
  import flails.clients.RailsClient;
  import flails.clients.ResourceClient;
  import flails.request.HTTPFilter;
  import flails.request.JSONFilter;
  import flails.request.RequestConfig;
  import flails.request.Result;

  import mx.utils.ObjectUtil;

  public class RailsResource implements IResource {
    private var filter:HTTPFilter;
    private var config:Object;
    private var identityMap:IdentityMap;

    public function RailsResource(config:Object) {
      this.config      = config;
      this.identityMap = new IdentityMap(config.modelClass);
      filter           = new JSONFilter();
    }
    
    public function index(data:Object = null):Result {
      return client(collection('index'), HTTPRequestMethod.GET, requestData(data)).send();
    }

    public function show(id:Object = null, data:Object = null):Result {
      return client(member('show', id), HTTPRequestMethod.GET, requestData(data)).send();
    }

    public function create(data:Object = null):Result {
      return client(collection('create'), HTTPRequestMethod.POST, requestData(data)).send();
    }

    public function update(id:Object = null, data:Object = null):Result {
      return client(member('update', id), HTTPRequestMethod.PUT, requestData(data)).send();
    }

    public function destroy(id:Object, data:Object = null):Result {
      return client(member('destroy', id), HTTPRequestMethod.DELETE, requestData(data)).send();
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

    private function client(url:String, method:String, data:Object):RailsClient {
      var c:RailsClient = new RailsClient(url, method, data);

      c.result      = new Result(fromIdentityMap);
      c.contentType = filter.contentType;
      
      return c;
    }

    private function fromIdentityMap(data:Object):* {
      var result:* = filter.load(data);

      if (result is Array) {
        return identityMap.fetchAndUpdateArray("id", result as Array);
      }

      return identityMap.fetchAndUpdate(result.id, result);
    }

    private function requestData(data:Object):Object {
      var out:Object = new Object();

      if (config.requestConfig) {
        for each (var o:Object in config.requestConfig.extraParams) {
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