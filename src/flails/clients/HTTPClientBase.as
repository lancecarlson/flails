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

  import flails.request.HTTPFilter;
  import flails.request.Result;
  
  public class HTTPClientBase extends EventDispatcher {
    public static const METHOD_POST:String = "POST";
    public static const METHOD_GET:String = "GET";
    public static const METHOD_PUT:String = "PUT";
    public static const METHOD_DELETE:String = "DELETE";

    public var filter:HTTPFilter;

    protected var log:ILogger;
    
    private var url:String;
    private var method:String;

    public function HTTPClientBase(url:String, method:String = METHOD_GET) {
      this.url    = url;
      this.method = method;
    }

    public function send(... args):Result {
      log.debug("Sending request to " + url + " [" + method + "]");

      var loader:URLLoader = new URLLoader();
      var result:Result    = new Result(filter);

      loader.addEventListener(Event.COMPLETE, result.onComplete);
      //loader.addEventListener(IOErrorEvent.IO_ERROR, onError);

      loader.load(request(url, args.length == 1 ? args[0] : null, method, filter));

      return result;
    }

    protected function request(url:String, args:Object, method:String, filter:HTTPFilter):URLRequest {
      throw new IllegalOperationError("This method needs to be overriden");
    }
  }
}
