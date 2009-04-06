package test.request {

  import net.digitalprimates.fluint.tests.TestCase;
  
  import mx.rpc.events.ResultEvent;
  
  import flails.request.HTTPClient;
  import flails.request.ResourcePathBuilder;
  import flails.request.RemoteClient;
  import flails.request.RequestConfig;

  public class RemoteClientTest extends TestCase {

    override protected function setUp():void {
      var cleanup:HTTPClient = new HTTPClient(null, null, new RequestConfig())
      cleanup.addEventListener("result", asyncHandler(pendUntilComplete, 1000))
      cleanup.doGet("/posts/reset");
    }
    
    public function testIndex():void {
      var r:RemoteClient = new RemoteClient(new ResourcePathBuilder("posts", "amf"));
      r.addEventListener("result", asyncHandler(function (e:ResultEvent, data:Object):void {
            var a:Array = e.result as Array;

            assertEquals(2, a.length);
            assertEquals('testFindAll #1', a[0].subject);
            assertEquals('testFindAll #1 body', a[0].body);
            assertEquals('testFindAll #2', a[1].subject);
            assertEquals('testFindAll #2 body', a[1].body);
          }, 1000));
      r.index();
    }
  }
}