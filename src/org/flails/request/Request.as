package org.flails.request {
  
  import mx.controls.Alert;

  import flash.events.*;
  import flash.net.*;
  
  import com.adobe.serialization.json.*;
  
  public class Request {
    public var resource:String;
    public var resourceID:uint;
    public var method:String = "GET";
    public var serialization:String = "json";
    private var service:*;
    private var loader:URLLoader = new URLLoader();
    private var request:URLRequest = new URLRequest();
    
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
      
      this.request.url = requestPath().fullPath();
      this.request.method = method;
/*      this.request.data = new URLVariables("name=John+Doe");*/
      
      if (this.method == "GET") {
        addHeader("Content-Type", "application/json");
      } else if (this.method == "POST") {
        addHeader("Content-Type", "application/x-www-form-urlencoded");
      }
    }
    
    public function dispatch():Request {
      this.loader.load(this.request);
      return this;
    }
    
    public function onComplete(completeHandler:Function):void {      
      var completeHandlerProxy:Function = function(event:Event):void {
        var response:URLLoader = URLLoader(event.target);
        var serializedData:* = new JSONService(response.data).encode();
        
        completeHandler.call(this, serializedData);
      }
        
      addHandler("complete", completeHandlerProxy);
    }
    
    public function onError(errorHandler:Function):void {
      addHandler("ioError", errorHandler);
    }
    
    public function addHeader(name:String, value:String):void {
      this.request.requestHeaders.push(new URLRequestHeader(name, value));
    }
    
    private function requestPath():RequestPath {
      return new RequestPath(this.resource, null, this.resourceID, "json");
    }
    
    private function addHandler(handlerType:String, handlerFunction:Function):void {
      this.loader.addEventListener(handlerType, handlerFunction);
    }

  }
}