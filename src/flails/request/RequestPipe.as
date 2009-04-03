package flails.request {
  import flash.events.IEventDispatcher;
  public interface RequestPipe extends IEventDispatcher {
    function index():void;
    
    function show(id:Object = null):void;
    
    function update(data:Object, id:Object):void;
    
    function create(data:Object, id:Object = null):void;
    
    function destroy(id:Object):void;
  }
}
