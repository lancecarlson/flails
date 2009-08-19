package test {
  import flails.IdentityMap;

  import test.FlailsTest;
  
  public class IdentityMapTestFetchAndUpdateArray extends FlailsTest {
    private var im:IdentityMap;

    override protected function setUp():void {
      im = new IdentityMap(TheClass);
    }
    
    public function testInstatiatesClass():void {
      for each (var o:TheClass in im.fetchAndUpdateArray("id", [{id: "me", attr1: "val1"}, {id: "you", attr1: "val11"}]));
    }
  }
}

import flails.resource.Record;

dynamic class TheClass extends Record {
  public function TheClass(attributes:Object) { super(attributes); }
}