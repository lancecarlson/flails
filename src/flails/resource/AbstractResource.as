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

  public class AbstractResource extends EventDispatcher implements IResource {
    public function index(data:Object = null):Result {
      throw new IllegalOperationError("Not implemented");
    }

    public function show(id:Object = null, data:Object = null):Result {
      throw new IllegalOperationError("Not implemented");
    }

    public function create(data:Object = null):Result {
      throw new IllegalOperationError("Not implemented");
    }

    public function update(id:Object = null, data:Object = null):Result {
      throw new IllegalOperationError("Not implemented");
    }

    public function destroy(id:Object, data:Object = null):Result {
      throw new IllegalOperationError("Not implemented");
    }
  }
}
