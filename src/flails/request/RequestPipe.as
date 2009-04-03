package flails.request {
  import flash.events.IEventDispatcher;
  public interface RequestPipe extends IEventDispatcher {
    function index():void;
    
    function show(id:Object = null):void;
    
    function update(id:Object, data:Object):void;
    
    function create(data:Object):void;
    
    function destroy(id:Object):void;
  }
}
