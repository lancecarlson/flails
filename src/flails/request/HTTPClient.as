/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

/*
Client does not handle status codes over 200 because of flash and URLLoader. Therefore, all validation 
errors or NotFound errors need to be sent back with a 200 status code. Whenever an exception is raised, 
an IOError is fired which is automatically handled by the framework to Alert that there was a problem. 

Check this for details: 

http://stackoverflow.com/questions/188887/how-to-access-as3-urlloader-return-data-on-ioerrorevent
*/
package flails.request {
  import flash.events.EventDispatcher;
  import flash.events.Event;

  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.net.URLRequestHeader;
  import flash.net.URLVariables;

  import mx.rpc.events.ResultEvent;

  import flails.request.Filter;
  import flails.request.PathBuilder;
  import flails.request.RequestPipe;
  
  //import com.adobe.serialization.json.*;
  
  public class HTTPClient extends EventDispatcher implements RequestPipe {
    private var loader:URLLoader = new URLLoader();
    private var request:URLRequest = new URLRequest();
    private var errorHandler:Function;

    private var pathBuilder:PathBuilder;
    private var filter:Filter;
    private var config:RequestConfig;
    
    // Dispatched after all the received data is decoded and placed in the data property of the URLLoader object. The received data may be accessed once this event has been dispatched.
    public const COMPLETE:String = "complete";
    
    // Dispatched when the download operation commences following a call to the URLLoader.load() method.
    public const OPEN:String = "open";
    
    // Dispatched when data is received as the download operation progresses.
    public const PROGRESS:String = "progress"; 
    
    // Dispatched if a call to URLLoader.load() attempts to access data over HTTP and the current Flash Player environment is able to detect and return the status code for the request.
    public const HTTP_STATUS:String = "httpStatus";
    
    // Dispatched if a call to URLLoader.load() results in a fatal error that terminates the download.
    public const IO_ERROR:String = "ioError";
    
    // Dispatched if a call to URLLoader.load() attempts to load data from a server outside the security sandbox.
    public const SECURITY_ERROR:String = "securityError";
    
    public function HTTPClient(pathBuilder:PathBuilder, filter:Filter, config:RequestConfig) {
      this.pathBuilder = pathBuilder;
      this.filter      = filter;
      this.config      = config;
    }
    
    public function index():void {
      trace("entered index");

      configureRequest({}, "GET");

      doGet(pathBuilder.index());
    }
    
    public function show(id:Object = null):void {
      configureRequest({}, "GET");

      doGet(pathBuilder.show(id));
    }
    
    public function create(data:Object):void {
      configureRequest(data, "POST");
      
      doPost(pathBuilder.create());
    }

    public function update(data:Object, id:Object = null):void {
      configureRequest(data, "PUT");

      doPost(pathBuilder.update(id));
    }
    
    public function destroy(id:Object):void {
      configureRequest({}, "DELETE");
      
      doPost(pathBuilder.destroy(id));
    }

    private function configureRequest(params:Object, method:String):void {
      trace("configuring...")
      var variables:URLVariables = new URLVariables();
      
      // TODO: This is rails specific. Move it somewhere more appropriate
      if (method == "PUT" || method == "DELETE") {
        variables["_method"] = method.toLowerCase();
      }

      trace("Adding " + config.extraParams.length + " extra variables");
      for each (var p:RequestParam in config.extraParams) {
        trace("adding extra var " + p.name + " with value " + p.value); 
        variables[p.name] = p.value;
      }

      // replace this with filter.dump(params). Make ARSON filter take care of the resource[param] concatenation
      paramsToVariables(variables, params);

      request.data = variables;
    }
    
    private function paramsToVariables(variables:URLVariables, params:Object, prefix:String = null):void {
      for (var param:String in params) {
        var name:String;

        if (prefix) {
          name = prefix + "[" + param + "]";
        } else {
          name = param;
        }

        trace("setting variable " + name);

        if (!(params[param] is String) && !(params[param] is Number)) {
          trace("param " + param + " is an object (" + params[param].constructor + ")");
          paramsToVariables(variables, params[param], name);
        } else {
          trace("value for param" + param + " is " + params[param]);
          variables[name] = params[param];
        }
      }
    }

    private function onComplete(event:Event):void {      
      var response:URLLoader = URLLoader(event.target);
      
      if (response.data.replace(" ", "").length != 0) {
        dispatchEvent(new ResultEvent("result", false, false, filter.load(response.data)));
      } else {
        dispatchEvent(new ResultEvent("result"));
      }
    }

    private function addHeader(name:String, value:String):void {
      request.requestHeaders.push(new URLRequestHeader(name, value));
    }
    
    public function doGet(url:String):void {
      trace("entering doGet");
      // TODO: This should be set by the filter
      addHeader("Content-Type", "application/json");

      trace("setting url " + config.baseUrl + url);
      request.url = config.baseUrl + url;
      
      loader.addEventListener("complete", onComplete);
      loader.load(request);
    }

    public function doPost(url:String):void {
      trace("entering doPost");
      addHeader("Content-Type", "application/x-www-form-urlencoded");

      request.method = "POST";
      trace("setting url " + config.baseUrl + url);
      request.url = config.baseUrl + url;

      loader.addEventListener("complete", onComplete);
      loader.load(request);
    }
  }
}
