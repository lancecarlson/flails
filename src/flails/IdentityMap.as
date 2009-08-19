package flails {
  import flash.utils.Dictionary;

  import mx.collections.ArrayCollection;

  public class IdentityMap {
    private var map:Dictionary = new Dictionary();
    private var modelClass:Class;

    public function IdentityMap(modelClass:Class) {
      this.modelClass = modelClass;
    }

    public function fetchAndUpdateArray(idProperty:String, data:Array):Array {
      return data.map(function(item:*, ... rest):Object {
        return fetchAndUpdate(item[idProperty], item);
      });
    }

    public function fetchAndUpdate(id:Object, attributes:Object):* {
      if (id == null) {
        return new modelClass(attributes);
      }

      if (map[id] == null) {
        map[id] = new modelClass(attributes);
      }

      return map[id];
    }
  }
}