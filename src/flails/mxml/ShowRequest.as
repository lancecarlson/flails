package flails.mxml {
  import mx.core.IMXMLObject;

  import flails.resources.Resource;

  public class ShowRequest extends Request {
    public function ShowRequest() {}

    public var targetId:Object;
    public var resource:Resource;

    public function initialized(parent:Object, id:String):void {
    }
  }
}