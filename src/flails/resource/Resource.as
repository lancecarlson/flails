package flails.resource {
  import flash.events.EventDispatcher;
  import flash.events.Event;
  import flash.errors.IllegalOperationError;

  import flails.clients.ResourceClient;
  import flails.request.Filter;
  import flails.request.PathBuilder;
  import flails.request.RequestPipe;
  import flails.request.RequestConfig;
  import flails.request.RequestParam;
  import flails.request.Result;

  import mx.core.IMXMLObject;

  public class Resource extends EventDispatcher implements IMXMLObject {
    public var name:String;

    private var parent:Object;
    private var id:String;

    public function initialized(parent:Object, id:String):void {
      this.parent = parent;
      this.id     = id;
    }

    public function index(data:Object = null, completeHandler:Function = null):Result {
      throw new IllegalOperationError("Not implemented");
    }

    public function show(id:Object = null, data:Object = null, completeHandler:Function = null):Result {
      throw new IllegalOperationError("Not implemented");
    }

    public function create(data:Object = null, completeHandler:Function = null):Result {
      throw new IllegalOperationError("Not implemented");
    }

    public function update(id:Object = null, data:Object = null, completeHandler:Function = null):Result {
      throw new IllegalOperationError("Not implemented");
    }

    public function destroy(id:Object, data:Object = null, completeHandler:Function = null):Result {
      throw new IllegalOperationError("Not implemented");
    }
  }
}
