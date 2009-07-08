package flails.clients {
  import flails.request.HTTPFilter;

  import flash.net.URLRequestHeader;
  import flash.net.URLRequestMethod;
  import flash.net.URLRequest;
  import flash.net.URLVariables;

  import mx.logging.ILogger;
  import mx.logging.Log;

  public class HTTPRailsClient extends HTTPClientBase {
    public function HTTPRailsClient(url:String, filter:HTTPFilter, method:String, completeHandler:Function = null, errorHandler:Function = null) {
      super(url, filter, method, completeHandler, errorHandler);

      this.log = Log.getLogger("flails.clients.HTTPRailsClient");
    }

    override protected function request(url:String, args:Object, method:String, filter:HTTPFilter):URLRequest {
      var r:URLRequest = new URLRequest(url);

      r.contentType = contentType(filter, method);
      r.method      = requestMethod(method);
      r.data        = argsToVariables(args, method);

      return r;
    }

    private function requestMethod(method:String):String {
      return method == HTTPClientBase.METHOD_GET ? URLRequestMethod.GET : URLRequestMethod.POST;
    }

    private function contentType(filter:HTTPFilter, method:String):String {
      if (method == HTTPClientBase.METHOD_GET) {
        return filter.contentType;
      } else {
        return "application/x-www-form-urlencoded";
      }
    }

    private function argsToVariables(params:Object, method:String):Object {
      var variables:URLVariables = new URLVariables();
      
      if (method == HTTPClientBase.METHOD_PUT || method == HTTPClientBase.METHOD_DELETE) {
        variables["_method"] = method.toLowerCase();
      }

      paramsToVariables(variables, params);

      return variables;
    }
    
    private function paramsToVariables(variables:URLVariables, params:Object, prefix:String = null):void {
      if (params is Array) {
        for (var i:int = 0; i < params.length; i++) {
          if (!(params[i] is String) && !(params[i] is Number)) {
            paramsToVariables(variables, params[i], prefix + "[" + i + "]");
          } else {
            variables[prefix + "[" + i + "]"] = params[i];
          }
        }
      } else {
        for (var param:String in params) {
          var name:String;
      
          if (prefix) {
            name = prefix + "[" + param + "]";
          } else {
            name = param;
          }

          if (!(params[param] is String) && !(params[param] is Number)) {
            paramsToVariables(variables, params[param], name);
          } else {
            variables[name] = params[param];
          }
        }
      }
    }
  }
}