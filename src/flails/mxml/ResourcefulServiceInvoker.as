package flails.mxml {
  import com.asfusion.mate.actions.AbstractServiceInvoker;
  import com.asfusion.mate.actionLists.IScope;
  import com.asfusion.mate.actions.IAction;

  import mx.rpc.events.ResultEvent;
  import mx.rpc.events.FaultEvent;

  import flails.request.RequestPipe;
  import flails.resource.Resources;
  import flails.resource.Resource;

  public class ResourcefulServiceInvoker extends AbstractServiceInvoker implements IAction {
    private var _data:Array;

    public var resource:Resource;
    public var type:String;
    public var id:String;
    public var parent:Object;

    [Bindable] public var result:Object;

    public function set data(args:Object):void {
      trace("setting data");

      if (args is Array)
        _data = args as Array;
      else
        _data = [args];
    }

    override protected function prepare(scope:IScope):void {
      currentInstance = this;

      super.prepare(scope);
    }

    override protected function run(scope:IScope):void {
      trace ("Using resource " + resource);

      var rp:RequestPipe = resource.newRequestPipe();

      innerHandlersDispatcher = rp;

      if (resultHandlers && resultHandlers.length > 0) {
        createInnerHandlers(scope, ResultEvent.RESULT, resultHandlers);
      }
      
      if (faultHandlers && faultHandlers.length > 0) {
        createInnerHandlers(scope, FaultEvent.FAULT, faultHandlers);
      }
      
      trace("calling " + type + "() with " + _data);

      rp[type].apply(rp, _data);
    }
  }
}