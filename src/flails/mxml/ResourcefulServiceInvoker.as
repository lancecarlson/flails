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
    public var resource:Resource;
    public var data:Object;
    public var targetId:Object;
    public var type:String;
    public var id:String;
    public var parent:Object;

    [Bindable] public var result:Object;

    public function ResourcefulServiceInvoker() { super(); }

    override protected function prepare(scope:IScope):void {
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
      
      if (data != null && targetId != null) {
        rp[type](data, targetId);
      }
      else if (data != null) {
        rp[type](data);
      }
      else if (targetId != null) {
        trace("calling " + type + "(" + targetId + ")")
          rp[type](targetId);
      } else {
        trace("calling " + type)
          rp[type]();
      }
    }
  }
}