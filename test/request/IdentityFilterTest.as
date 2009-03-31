package test.request {
  import mx.rpc.events.ResultEvent;

  import flails.request.IdentityFilter;
  import flails.resource.Record;
  
  import net.digitalprimates.fluint.tests.TestCase;

  public class IdentityFilterTest extends TestCase {
    public function testLoadResultList():void {
      var f:IdentityFilter = new IdentityFilter();
      var aOrig:Array = [{attr1: 1, attr2: 2}, {attr1: 3, attr2: 4}];
      var a:Array = f.load(aOrig) as Array;

      assertEquals(2, a.length);
      assertEquals(Record, a[0].constructor);
      assertEquals(1, a[0].attr1)
      assertEquals(2, a[0].attr2)
      assertEquals(Record, a[1].constructor);
      assertEquals(3, a[1].attr1)
      assertEquals(4, a[1].attr2)
    }

    public function testLoadResultListAsCustomRecord():void {
      var f:IdentityFilter = new IdentityFilter(Post);
      var aOrig:Array = [{attr1: 1, attr2: 2}, {attr1: 3, attr2: 4}];
      var a:Array = f.load(aOrig) as Array;

      assertEquals(Post, a[0].constructor);
      assertEquals(Post, a[1].constructor);
    }

    public function testLoadRecord():void {
      var f:IdentityFilter = new IdentityFilter();
      var orig:Object = {attr1: 1, attr2: 2};
      var a:Record = f.load(orig) as Record;

      assertEquals(Record, a.constructor);
      assertEquals(1, a.attr1)
      assertEquals(2, a.attr2)
    }

    public function testLoadCustomRecord():void {
      var f:IdentityFilter = new IdentityFilter(Post);
      var orig:Object = {attr1: 1, attr2: 2};
      var a:Record = f.load(orig) as Record;

      assertEquals(Post, a.constructor);
    }
  }
}

import flails.resource.Record;

dynamic class Post extends Record {
  public function Post(attributes:Object = null) {
    super(attributes);
  }
}
