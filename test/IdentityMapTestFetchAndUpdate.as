package test {
  import flails.IdentityMap;

  import test.FlailsTest;
  
  public class IdentityMapTestFetchAndUpdate extends FlailsTest {
    private var im:IdentityMap;

    override protected function setUp():void {
      im = new IdentityMap(TheClass);
    }
    
    public function testInstatiatesClass():void {
      assertEquals(TheClass, im.fetchAndUpdate("me", {id: "me", attr1: "val1"}).constructor);      
    }

    public function testSetsNewModel():void {
      var result:TheClass = TheClass(im.fetchAndUpdate("me", {id: "me", attr1: "val1"}));

      assertEquals("me", result.id);
      assertEquals("val1", result.attr1);
    }

    public function testDoesNotSetObjectWithNullId():void {
      im.fetchAndUpdate(null, {id: null, attr1: "val1"});

      assertNull(im.fetchAndUpdate(null, {id: null, attr2: "val2"}).attr1);
      assertNotNull(im.fetchAndUpdate(null, {id: null, attr2: "val2"}).attr2);
    }

    public function testFetchExistingModel():void {
      im.fetchAndUpdate("yo", {id: "yo", attr1: "val1"});

      assertEquals("val1", im.fetchAndUpdate("yo", {}).attr1);
    }
  }
}

import flails.resource.Record;

dynamic class TheClass extends Record {
  public function TheClass(attributes:Object) { super(attributes); }
}