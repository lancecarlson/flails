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

  import flails.request.Result;
  import flails.request.IdentityFilter;
  
  public class JavaScriptClient extends EventDispatcher {
    protected var log:ILogger;

    private var methodName:String;

    public function JavaScriptClient(methodName:String) {
      log = Log.getLogger("flails.clients.JavaScriptClient");

      this.methodName = methodName;
    }

    public function send(... args):Result {
      log.debug("Calling " + methodName);

      var result:Result = new Result(new IdentityFilter());

      ExternalInterface.addCallback(methodName + "Result", function(data:Object):void {
        log.debug("Called back " + methodName + "Result" + " with result: " + data);

        result.result = data;
      });
      ExternalInterface.addCallback(methodName + "Error", onError);

      ExternalInterface.call.apply(ExternalInterface, [methodName].concat(args));

      return result;
    }

    protected function onComplete(data:Object):void {      
      dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, false, data));
    }
 
    protected function onError(error:Object):void {
      dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, error.message));
    }
  }
}
