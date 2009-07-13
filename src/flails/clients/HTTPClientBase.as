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
  
  import mx.rpc.events.ResultEvent;
  import mx.logging.ILogger;
  import mx.logging.Log;

  import flails.request.HTTPFilter;
  
  public class HTTPClientBase extends EventDispatcher {
    public static const METHOD_POST:String = "POST";
    public static const METHOD_GET:String = "GET";
    public static const METHOD_PUT:String = "PUT";
    public static const METHOD_DELETE:String = "DELETE";

    protected var log:ILogger;

    private var filter:HTTPFilter;
    private var url:String;
    private var loader:URLLoader;
    private var method:String;

    public function HTTPClientBase(url:String, filter:HTTPFilter, method:String, completeHandler:Function = null, errorHandler:Function = null) {
      this.filter    = filter;
      this.url       = url;
      this.loader    = new URLLoader();
      this.method    = method;

      loader.addEventListener(Event.COMPLETE, onComplete);
      loader.addEventListener(IOErrorEvent.IO_ERROR, onError);

      if (completeHandler != null)
        addEventListener(ResultEvent.RESULT, completeHandler);
      
      if (errorHandler != null)
        addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
    }

    public function send(args:Object = null):void {
      log.debug("Sending request to " + url + " [" + method + "]");

      loader.load(request(url, args, method, filter));
    }

    protected function request(url:String, args:Object, method:String, filter:HTTPFilter):URLRequest {
      throw new IllegalOperationError("This method needs to be overriden");
    }

    protected function onComplete(event:Event):void {      
      var response:URLLoader = URLLoader(event.target);
      
      if (response.data.replace(" ", "").length != 0)
        dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, false, filter.load(response.data)));
      else
        dispatchEvent(new ResultEvent(ResultEvent.RESULT));
    }
 
    protected function onError(e:IOErrorEvent):void {
      dispatchEvent(e);
    }
  }
}
