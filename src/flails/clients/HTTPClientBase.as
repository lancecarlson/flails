/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
package flails.clients {
  import flash.events.EventDispatcher;
  import flash.events.Event;
  import flash.events.IOErrorEvent;

  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.net.URLRequestHeader;
  import flash.net.URLVariables;
  import flash.errors.IllegalOperationError;
  
  import mx.logging.ILogger;
  import mx.logging.Log;
  import mx.utils.ObjectUtil;

  import flails.request.HTTPFilter;
  import flails.request.Result;
  
  public class HTTPClientBase extends EventDispatcher {
    public static const METHOD_POST:String = "POST";
    public static const METHOD_GET:String = "GET";
    public static const METHOD_PUT:String = "PUT";
    public static const METHOD_DELETE:String = "DELETE";

    public var contentType:String;
    public var result:Result;

    protected var log:ILogger;
    
    private var url:String;
    private var method:String;

    public function HTTPClientBase(url:String, method:String = METHOD_GET) {
      this.url    = url;
      this.method = method;
    }

    public function send(... args):Result {
      if (Log.isDebug()) {
        log.debug("Sending request to " + url + " [" + method + "]");
        log.debug("Request data: " + ObjectUtil.toString(args));
      }

      var loader:URLLoader = new URLLoader();

      loader.addEventListener(Event.COMPLETE, function(e:Event):void {
        result.onComplete(e);
        loader.removeEventListener(Event.COMPLETE, arguments.callee);
      });

      //loader.addEventListener(IOErrorEvent.IO_ERROR, onError);

      loader.load(request(url, args.length == 1 ? args[0] : null, method, contentType));

      return result;
    }

    protected function request(url:String, args:Object, method:String, contentType:String):URLRequest {
      throw new IllegalOperationError("This method needs to be overriden");
    }
  }
}
