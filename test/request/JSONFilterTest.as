package test.request {
  import mx.rpc.events.ResultEvent;

  import flails.request.JSONFilter;
  import flails.resource.Record;
  
  import net.digitalprimates.fluint.tests.TestCase;

  public class JSONFilterTest extends TestCase {
    public function testLoadResultList():void {
      var f:JSONFilter = new JSONFilter();
      var str:String = '[{"attr1": 1, "attr2": 2},{"attr1": 3, "attr2": 4}]';
      var a:Array = f.load(str) as Array;

      assertEquals(2, a.length);
      assertEquals(Record, a[0].constructor);
      assertEquals(1, a[0].attr1)
      assertEquals(2, a[0].attr2)
      assertEquals(Record, a[1].constructor);
      assertEquals(3, a[1].attr1)
      assertEquals(4, a[1].attr2)
    }

    public function testLoadResultListAsCustomRecord():void {
      var f:JSONFilter = new JSONFilter(Post);
      var str:String = '[{"attr1": 1, "attr2": 2},{"attr1": 3, "attr2": 4}]';
      var a:Array = f.load(str) as Array;

      assertEquals(Post, a[0].constructor);
      assertEquals(Post, a[1].constructor);
    }

    public function testLoadRecord():void {
      var f:JSONFilter = new JSONFilter();
      var str:String = '{"attr1": 1, "attr2": 2}';
      var a:Record = f.load(str) as Record;

      assertEquals(Record, a.constructor);
      assertEquals(1, a.attr1)
      assertEquals(2, a.attr2)
    }

    public function testLoadCustomRecord():void {
      var f:JSONFilter = new JSONFilter(Post);
      var str:String = '{"attr1": 1, "attr2": 2}';
      var a:Record = f.load(str) as Record;

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
