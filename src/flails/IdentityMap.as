package flails {
  import flash.utils.Dictionary;

  import mx.collections.ArrayCollection;

  public class IdentityMap {
    private var map:Dictionary = new Dictionary();
    private var modelClass:Class;

    public function IdentityMap(modelClass:Class) {
      this.modelClass = modelClass;
    }

    public function fetchAndUpdateCollection(idProperty:String, data:Array):ArrayCollection {
      var coll:ArrayCollection = new ArrayCollection();

      for each (var o:Object in data) {
        coll.addItem(fetchAndUpdate(o[idProperty], o));
      }

      return coll;
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