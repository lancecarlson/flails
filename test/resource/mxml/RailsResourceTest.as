package test.resource.mxml {
  import mx.rpc.events.ResultEvent;

  import flails.clients.HTTPClientBase;
  import flails.clients.RailsClient;
  import flails.request.JSONFilter;
  import flails.resource.mxml.RailsResource;
  
  import net.digitalprimates.fluint.tests.TestCase;

  public class RailsResourceTest extends TestCase {
    private var r:RailsResource;

    override protected function setUp():void {
      new RailsClient("http://localhost:3000/posts/reset", 
                      new JSONFilter(), 
                      HTTPClientBase.METHOD_GET, 
                      asyncHandler(pendUntilComplete, 1000)).send();
    }

    public function testIndex():void {
      resource.index(null, asyncHandler(function (e:ResultEvent, data:Object):void {
        var a:Array = e.result as Array;
        
        assertEquals(2, a.length);
        assertEquals('testFindAll #1', a[0].subject);
        assertEquals('testFindAll #1 body', a[0].body);
        assertEquals('testFindAll #2', a[1].subject);
        assertEquals('testFindAll #2 body', a[1].body);
      }, 1000));
    }

    public function testShow():void {
      resource.show(1, null, asyncHandler(function (e:ResultEvent, data:Object):void {
        assertEquals('testFindAll #1', e.result.subject);
        assertEquals('testFindAll #1 body', e.result.body);
      }, 1500));
    }

    public function testCreate():void {
      resource.create({post: {subject: "creating new post", body: "creating new post with body"}}, 
                      asyncHandler(function(e:ResultEvent, data:Object):void {
                        resource.show(e.result.id, null, asyncHandler(function(rs:ResultEvent, data:Object):void {
                          assertEquals('creating new post', rs.result.subject);
                          assertEquals('creating new post with body', rs.result.body);
                        }, 1500));
                      }, 1500));
    }

    public function testUpdate():void {
      resource.update(2, 
                      {post: {subject: "testFindAll #2 updated", body: "testFindAll #2 body updated"}},
                      asyncHandler(function(e:ResultEvent, data:Object):void {
                        resource.show(e.result.id, null, asyncHandler(function (r:ResultEvent, data:Object):void {
                          assertEquals('testFindAll #2 updated', r.result.subject);
                          assertEquals('testFindAll #2 body updated', r.result.body);
                        }, 1500));
                      }, 1500));
    }

    public function testDestroy():void {
      resource.destroy(2, null, asyncHandler(function(e:ResultEvent, data:Object):void {
        var p:Object = e.result;
        
        assertEquals(2, p.id);
        
        resource.show(p.id, null, asyncHandler(function (e:ResultEvent, data:Object):void {
          assertEquals(null, e.result.id);
        }, 1500));
      }, 1500));
    }

    private function get resource():RailsResource {
      var r:RailsResource = new RailsResource();

      r.baseURL = "http://localhost:3000";
      r.name    = "posts"
      r.initialized(null, null);

      return r;
    }
  }
}
