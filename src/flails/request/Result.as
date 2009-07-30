package flails.request {
  import mx.rpc.IResponder;
  import mx.collections.ItemResponder;

  import flash.net.URLLoader;
  
  import mx.logging.ILogger;
  import mx.logging.Log;
  import mx.utils.ObjectUtil;

  public class Result {
    private var _responder:IResponder;
    private var _result:Object;
    private var filter:Filter;
    private var log:ILogger;
    
    public function Result(filter:Filter) {
      this.filter = filter;
      this.log    = Log.getLogger("flails.request.Result");
    }

    public function get responder():IResponder {
      return _responder;
    }

    [Bindable]
    public function set result(value:Object):void {
      if (Log.isDebug())
        log.debug("Result data: " + ObjectUtil.toString(value));

      _result = value;

      if (_responder != null) {
        _responder.result(_result);
      }
    }
    
    public function get result():Object {
      return _result;
    }

    public function set responder(responder:IResponder):void {
      _responder = responder;

      if (_result != null)
        _responder.result(_result);
    }
    
    public function set completeHandler(handler:Function):void {
      responder = new ItemResponder(function(data:Object, token:Object = null):void { 
        handler(data);
      }, null);
    }
  
    public function onComplete(event:Event):void {      
      var response:URLLoader = URLLoader(event.target);
      
      if (response.data.replace(" ", "").length != 0) {
        result = filter.load(response.data);
      } else if (_responder != null) {
        _responder.result(null);
      }
    }
  }
}