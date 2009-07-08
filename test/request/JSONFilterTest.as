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
      assertEquals(Object, a[0].constructor);
      assertEquals(1, a[0].attr1)
      assertEquals(2, a[0].attr2)
      assertEquals(Object, a[1].constructor);
      assertEquals(3, a[1].attr1)
      assertEquals(4, a[1].attr2)
    }

    public function testLoadSingleResult():void {
      var f:JSONFilter = new JSONFilter();
      var str:String = '{"attr1": 1, "attr2": 2}';
      var a:Object = f.load(str);

      assertEquals(Object, a.constructor);
      assertEquals(1, a.attr1)
      assertEquals(2, a.attr2)
    }
  }
}
