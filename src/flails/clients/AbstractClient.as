package flails.clients {
  import flash.events.EventDispatcher;

  import mx.logging.ILogger;
  import mx.logging.Log;
  import mx.utils.ObjectUtil;

  import flails.request.Result;

  public class AbstractClient extends EventDispatcher {
    public var requestData:Object;
    public var result:Result;

    protected var log:ILogger;

    public function AbstractClient(requestData:Object) {
      this.requestData = requestData;
    }

    public function send():Result {
      if (Log.isDebug()) {
        log.debug("Request data: " + ObjectUtil.toString(requestData));
      }

      return result;
    }
  }
}