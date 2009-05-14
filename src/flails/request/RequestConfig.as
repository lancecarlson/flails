package flails.request {
  import mx.core.IMXMLObject;

  [Bindable]
  public class RequestConfig implements IMXMLObject {
    public function RequestConfig() {}

    public var extraParams:Array = [];
    public var baseUrl:String = "";
    public var id:String;
    public var parent:Object;

    public function initialized(parent:Object, id:String):void {
      this.parent = parent;
      this.id = id;
    }
  }
}