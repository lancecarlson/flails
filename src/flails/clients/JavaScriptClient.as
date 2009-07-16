/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
package flails.clients {
  import flash.events.EventDispatcher;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.external.ExternalInterface;

  import flash.errors.IllegalOperationError;

  import mx.rpc.events.ResultEvent;
  import mx.logging.ILogger;
  import mx.logging.Log;

  import flails.request.HTTPFilter;
  
  public class JavaScriptClient extends EventDispatcher {
    protected var log:ILogger;

    private var methodName:String;

    public function JavaScriptClient(methodName:String, completeHandler:Function = null, errorHandler:Function = null) {
      log = Log.getLogger("flails.clients.JavaScriptClient");

      this.methodName = methodName;
      
      if (completeHandler != null)
        addEventListener(ResultEvent.RESULT, completeHandler);

      if (errorHandler != null)
        addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
    }

    public function send(... args):void {
      log.debug("Calling " + methodName);

      ExternalInterface.addCallback(methodName + "Result", onComplete);
      ExternalInterface.addCallback(methodName + "Error", onError);

      ExternalInterface.call.apply(ExternalInterface, [methodName].concat(args));
    }

    protected function onComplete(data:Object):void {      
      dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, false, data));
    }
 
    protected function onError(error:Object):void {
      dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, error.message));
    }
  }
}
