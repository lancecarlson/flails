package flails.request {
  import mx.core.IMXMLObject;

  public class RequestParam implements IMXMLObject {
    public function RequestParam() {}

    public var name:String;
    public var value:Object;

    public function initialized(parent:Object, id:String):void {
    }
  }
}