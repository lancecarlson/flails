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
package org.flails.request {
  
  import flash.events.*;
  import flash.net.*;
  
  import mx.controls.Alert;
  
  import com.adobe.serialization.json.*;
  
  public class Request {
    public var resource:String;
    public var resourceID:uint;
    public var method:String = "GET";
    public var serialization:String = "json";
    private var service:*;
    private var loader:URLLoader = new URLLoader();
    private var request:URLRequest = new URLRequest();
    private var completeHandler:Function;
    private var errorHandler:Function;
    
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
    
    public function Request(resource:String) {
      this.resource = resource;
    }
    
    public function dispatch():Request {
      configureRequest();
      
      this.loader.load(this.request);
      return this;
    }
    
    public function pushParams(params:Object):void {
      var variables:URLVariables = new URLVariables();
      
      if (this.method == "PUT" || this.method == "DELETE") {
        variables["_method"] = this.method.toLowerCase();
      }
      
      // Nested parameters created to account for rails style parameter mapping example:
      // {"post" => {"body" => "test"}}
      for (var param:String in params) {
        variables[resource + "[" + param + "]"] = params[param];
      }
      
      this.request.data = variables;
    }
    
    public function onSuccess(completeHandler:Function):Request {
      return onComplete(completeHandler);
    }
    
    public function onComplete(completeHandler:Function):Request {      
      var completeHandlerProxy:Function = function(event:Event):void {
        var response:URLLoader = URLLoader(event.target);
        
        if (response.data.replace(" ", "").length != 0) {
          var serializer:* = new JSONSerializer(response.data);
          var serializedData:* = (resourceID == 0 && method != "POST") ? serializer.getList() : serializer.getFirst();
        } else {
          var serailizedData:Boolean = true;
        }
        
        completeHandler.call(this, serializedData);
      }
      
      addHandler("complete", completeHandlerProxy);
      
      return this;
    }
    
    public function onError(errorHandler:Function):void {
      this.errorHandler = errorHandler;
      
      var errorHandlerProxy:Function = function(event:Event):void {
        var response:URLLoader = URLLoader(event.target);

        errorHandler.call(this, response.data);
      }
      
      addHandler("ioError", errorHandlerProxy);
    }
    
    public function addHeader(name:String, value:String):void {
      this.request.requestHeaders.push(new URLRequestHeader(name, value));
    }
    
    private function requestPath(mime:String=null):RequestPath {
      return new RequestPath(this.resource, null, this.resourceID, mime);
    }
    
    private function addHandler(handlerType:String, handlerFunction:Function):void {
      this.loader.addEventListener(handlerType, handlerFunction);
    }
    
    private function configureRequest():void {
      
      this.request.url = requestPath("json").fullPath();
      
      if (this.method == "GET") {
        addHeader("Content-Type", "application/json");
      } else if (this.method == "POST" || this.method == "PUT" || this.method == "DELETE") {
        this.request.method = "POST";
        addHeader("Content-Type", "application/x-www-form-urlencoded");
      }
    }

  }
}