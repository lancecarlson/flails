package flails.request {
  import flash.events.IEventDispatcher;

  public interface RequestPipe extends IEventDispatcher {
    function index(extraParams:Object = null, ... parentIds):void;
    
    function show(id:Object = null, extraParams:Object = null, ... parentIds):void;
    
    function update(id:Object = null, data:Object = null, ... parentIds):void;
    
    function create(data:Object = null, ... parentIds):void;
    
    function destroy(id:Object, extraParams:Object = null, ... parentIds):void;
  }
}
