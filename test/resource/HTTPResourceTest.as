package test.resource {
  import mx.rpc.events.ResultEvent;

//  import flails.resource.HTTPResource;
  import flails.request.JSONFilter;
  import flails.resource.Record;
  import flails.request.ResourcePathBuilder;
  import flails.request.RequestConfig;
  
  import net.digitalprimates.fluint.tests.TestCase;

  public class HTTPResourceTest extends TestCase {
/*    private var r:HTTPResource;
    private var rCheck:HTTPResource;

    override protected function setUp():void {
      var cleanup:HTTPResource = new HTTPResource(null, null, new RequestConfig())
      cleanup.addEventListener("result", asyncHandler(pendUntilComplete, 1000))
      cleanup.doGet("/posts/reset");

      var rc:RequestConfig = new RequestConfig();
      rc.baseUrl = "http://localhost:3000";
      
      r = new HTTPResource(new ResourcePathBuilder("posts"), new JSONFilter(), rc);
      rCheck = new HTTPResource(new ResourcePathBuilder("posts"), new JSONFilter(), rc);
    }

    public function testIndex():void {
      r.addEventListener("result", asyncHandler(function (e:ResultEvent, data:Object):void {
            var a:Array = e.result as Array;

            assertEquals(2, a.length);
            assertEquals('testFindAll #1', a[0].subject);
            assertEquals('testFindAll #1 body', a[0].body);
            assertEquals('testFindAll #2', a[1].subject);
            assertEquals('testFindAll #2 body', a[1].body);
          }, 1000));
      r.index();
    }*/

/*    public function testShow():void {
      r.addEventListener("result", asyncHandler(function (e:ResultEvent, data:Object):void {
            var p:Record = new Record(e.result);

            assertEquals('testFindAll #1', p.subject);
            assertEquals('testFindAll #1 body', p.body);
          }, 1500));
      r.show(1);
    }
    
    public function testShowNotFound():void {
      r.addEventListener("result", asyncHandler(function (e:ResultEvent, data:Object):void {
            var p:Record = new Record(e.result);

            assertEquals('Record Not Found', p.message);
          }, 1500));
      r.show(2349324920);
    }
    
    public function testCreate():void {
      r.addEventListener("result", asyncHandler(verifyCreateComplete, 1500));

      r.create({post: {subject: "creating new post", body: "creating new post with body"}});
    }
    
    private function verifyCreateComplete(e:ResultEvent, data:Object):void {
      rCheck.addEventListener("result", asyncHandler(function (e:ResultEvent, data:Object):void {
        var p:Record = new Record(e.result);
        
        assertEquals('creating new post', p.subject);
        assertEquals('creating new post with body', p.body);
      }, 1500));
      
      rCheck.show(e.result.id);
    }
    
    public function testUpdate():void {
      r.addEventListener("result", asyncHandler(verifyUpdateComplete, 1500));
      r.update(2, {post: {subject: "testFindAll #2 updated", body: "testFindAll #2 body updated"}});
    }

    private function verifyUpdateComplete(e:ResultEvent, data:Object):void {
      rCheck.addEventListener("result", asyncHandler(function (e:ResultEvent, data:Object):void {
            var p:Record = new Record(e.result);

            assertEquals('testFindAll #2 updated', p.subject);
            assertEquals('testFindAll #2 body updated', p.body);
          }, 1500));
      rCheck.show(2);
    }
    
    public function testDestroy():void {
      r.addEventListener("result", asyncHandler(verifyDestroy, 1500));
      r.destroy(2);
    }
    
    private function verifyDestroy(e:ResultEvent, data:Object):void {
      var p:Record = new Record(e.result);
        
      assertEquals(2, p.id);
      
      rCheck.addEventListener("result", asyncHandler(function (e:ResultEvent, data:Object):void {
        var p2:Record = new Record;
        p2.setAttributes(e.result);
        
        assertEquals(null, p2.id);
      }, 1500));
      
      rCheck.show(p.id);
    }
*/
  }
}
