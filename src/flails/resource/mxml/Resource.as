/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package flails.resource.mxml {
  import flails.request.RequestPipe;
  import flails.request.Filter;
  import flails.request.JavaScriptClient;
  import flails.request.ResourcePathBuilder;
  import flails.request.ResourceJavaScriptBuilder;
  import flails.request.JSONFilter;
  import flails.request.IdentityFilter;
  import flails.request.RequestConfig;

  import flails.resource.HTTPResource;
  import flails.resource.Record;

  import mx.core.IMXMLObject;

  public class Resource implements IMXMLObject {
    private var requestPipeConstructor:Function;

    public var name:String;
    public var instanceClass:Class;
    public var requestAdapter:String;
    public var requestFilter:String;
    public var requestConfig:RequestConfig;
    public var resourceParent:Resource;
    
    public function Resource() {}
    
    public function initialized(parent:Object, id:String):void {
      if (name == null) throw new Error("Name not set for resource.");

      trace("initialized resource " + name);

      if (instanceClass == null) instanceClass = Record;

      if (requestFilter == null) requestFilter = "json";
      if (requestAdapter == null) requestAdapter = "http";

      if (requestConfig == null) requestConfig = new RequestConfig();

      requestPipeConstructor = buildRequestPipeConstructor(requestAdapter, buildRequestFilter(requestFilter));
    }

    public function newRequestPipe():RequestPipe {
      trace("creating new request pipe");
      trace("requestConfig is " + requestConfig);
      return requestPipeConstructor(requestConfig);
    }

    private function buildRequestFilter(type:String):Filter {
      switch (type) {
      case "json":
        return new JSONFilter(instanceClass);
      case "identity":
        return new IdentityFilter(instanceClass);
      default:
        throw new Error("No valid request filter found for param " + type);
      }
    }

    private function buildRequestPipeConstructor(adapter:String, filter:Filter):Function {
      switch (adapter) {
      case "js":
        return function(config:RequestConfig):RequestPipe {
          return new JavaScriptClient(new ResourceJavaScriptBuilder(name), filter);
        }
      case "http":
        return function(config:RequestConfig):RequestPipe {
          var b:ResourcePathBuilder;

          if (resourceParent)
            b = new ResourcePathBuilder(name, requestFilter, new ResourcePathBuilder(resourceParent.name));
          else
            b = new ResourcePathBuilder(name);

          return new HTTPResource(b, filter, config);
        }
      default:
        throw new Error("No valid request adapter found for param " + adapter);
      }
    }
  }
}
