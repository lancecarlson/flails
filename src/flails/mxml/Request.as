package flails.mxml {
  import mx.core.IMXMLObject;

  import mx.rpc.events.ResultEvent;

  import flails.request.RequestPipe;
  import flails.resource.Resources;
  import flails.resource.Resource;

  public class Request implements IMXMLObject {
    private var resource:Resource;

    public var targetId:Object;
    public var type:String;

    [Bindable] public var result:Object;

    public function Request() {}

    public function set resourceName(name:String):void {
      resource = Resources.getResource(name);
    }

    public function initialized(parent:Object, id:String):void {
    }

    public function send():void {
      var rp:RequestPipe = resource.newRequestPipe();

      rp.addEventListener("result", onResult);

      if (targetId != null) {
        trace("calling " + type + "(" + targetId + ")")
        rp[type](targetId);
      } else {
        trace("calling " + type)
        rp[type]();
      }
    }

    private function onResult(e:ResultEvent):void {
      result = e.result;
    }
  }
}