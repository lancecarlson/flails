package flails.resource {
  import mx.core.IMXMLObject;
  import flash.utils.Dictionary;

  [DefaultProperty("resources")]
  public class Resources implements IMXMLObject {
    private static var _resources:Dictionary = new Dictionary();

    public static function getResource(name:String):Resource {
      return _resources[name] as Resource;
    }

    public function set resources(rs:Array):void {
      for each (var r:Resource in rs) {
        _resources[r.name] = r;
      }
    }

    public function initialized(parent:Object, id:String):void {
    }
  }
}