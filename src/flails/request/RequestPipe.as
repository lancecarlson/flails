package flails.request {
  import flash.events.IEventDispatcher;
  public interface RequestPipe extends IEventDispatcher {
    function index():void;
    
    function show(id:Number):void;
    
    function update(id:Number, data:Object):void;
    
    function create(data:Object):void;
    
    //function destroy(id:Number):void;
  }
}
