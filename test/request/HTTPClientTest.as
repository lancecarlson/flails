package test.request {
  import mx.rpc.events.ResultEvent;

  import flails.request.HTTPClient;
  import flails.request.JSONFilter;
  import flails.request.Record;
  import flails.request.ResourcePathBuilder;
  
  import flexunit.framework.TestCase;
  
  public class HTTPClientTest extends TestCase {
    override public function setUp():void {
      new HTTPClient(null).doGet("/posts/reset");
    }

    public function testFindAll():void {
      var r:HTTPClient = new HTTPClient(new ResourcePathBuilder("posts"), new JSONFilter());
      r.addEventListener("result", addAsync(function (e:ResultEvent):void {
            var a:Array = e.result as Array;

            assertEquals(2, a.length);
            assertEquals('testFindAll #1', a[0].subject);
            assertEquals('testFindAll #1 body', a[0].body);
            assertEquals('testFindAll #2', a[1].subject);
            assertEquals('testFindAll #2 body', a[1].body);
          }, 1500));
      r.index();
    }

    public function testFindById():void {
      var r:HTTPClient = new HTTPClient(new ResourcePathBuilder("posts"), new JSONFilter());
      r.addEventListener("result", addAsync(function (e:ResultEvent):void {
            var p:Record = e.result as Record;

            assertEquals('testFindAll #1', p.subject);
            assertEquals('testFindAll #1 body', p.body);
          }, 1500));
      r.show(1);
    }
    
    public function testUpdate():void {
      var r:HTTPClient = new HTTPClient(new ResourcePathBuilder("posts"), new JSONFilter());
      r.addEventListener("result", addAsync(verifyUpdateComplete, 1500));
      r.update(2, {post: {subject: "testFindAll #2 updated", body: "testFindAll #2 body updated"}});
    }

    private function verifyUpdateComplete(e:ResultEvent):void {
      var r:HTTPClient = new HTTPClient(new ResourcePathBuilder("posts"), new JSONFilter());

      r.addEventListener("result", addAsync(function (e:ResultEvent):void {
            var p:Record = e.result as Record;

            assertEquals('testFindAll #2 updated', p.subject);
            assertEquals('testFindAll #2 body updated', p.body);
          }, 1500));
      r.show(2);
    }
  }
}