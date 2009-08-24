package test.resource {
  import mx.rpc.events.ResultEvent;
  import mx.collections.ArrayCollection;

  import flails.clients.HTTPRequestMethod;
  import flails.clients.RailsClient;
  import flails.request.JSONFilter;
  import flails.resource.RailsResource;
  import flails.request.Result;

  import test.FlailsTest;

  public class RailsResourceTest extends FlailsTest {
    override protected function setUp():void {
      var c:RailsClient = new RailsClient("http://localhost:3000/posts/reset", HTTPRequestMethod.GET);
      
      c.result      = new Result(new JSONFilter().load);
      c.contentType = JSONFilter.CONTENT_TYPE;

      c.send();
    }

    public function testIndex():void {
      doTest(resource.index(), function (a:Array):void {
        assertEquals(2, a.length);
        assertEquals('testFindAll #1', a[0].subject);
        assertEquals('testFindAll #1 body', a[0].body);
        assertEquals('testFindAll #2', a[1].subject);
        assertEquals('testFindAll #2 body', a[1].body);
      }, 1000);
    }

    public function testShow():void {
      doTest(resource.show(1), function (result:Object):void {
        assertEquals('testFindAll #1', result.subject);
        assertEquals('testFindAll #1 body', result.body);
      }, 1000);
    }

    public function testCreate():void {
      doTest(resource.create({post: {subject: "creating new post", body: "creating new post with body"}}), function(result:Object):void {
        doTest(resource.show(result.id), function(result2:Object):void {
          assertEquals('creating new post', result2.subject);
          assertEquals('creating new post with body', result2.body);
        }, 1000);
      }, 1000);
    }

    public function testUpdate():void {
      doTest(resource.update(2, {post: {subject: "testFindAll #2 updated", body: "testFindAll #2 body updated"}}), 
             function(result:Object):void {
               doTest(resource.show(result.id), function (result2:Object):void {
                 assertEquals('testFindAll #2 updated', result2.subject);
                 assertEquals('testFindAll #2 body updated', result2.body);
               }, 1000);
             }, 1000);
    }

    public function testDestroy():void {
      doTest(resource.destroy(2), function(result:Object):void {
        assertEquals(2, result.id);
        
        doTest(resource.show(result.id), function (result2:Object):void {
          assertEquals(null, result2.id);
        }, 1000);
      }, 1000);
    }

    private function get resource():RailsResource {
      return new RailsResource({baseURL: "http://localhost:3000", name: "posts", modelClass: Post});
    }
  }
}

import flails.resource.Record;

dynamic class Post extends Record {
  public function Post(attributes:Object = null) {
    super(attributes);
  }
}