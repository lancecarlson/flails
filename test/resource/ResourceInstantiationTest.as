package test.resource {
  import net.digitalprimates.fluint.tests.TestCase;

  import mx.rpc.events.ResultEvent;

  import flails.request.JavaScriptClient;
  import flails.request.RequestPipe;
  import flails.resource.mxml.Resource;
  
  public class ResourceInstantiationTest extends TestCase {
    public var r:Resource;

    override protected function setUp():void {
      r = new Resource();
      r.name = "posts";
    }

    public function testJSAdapterSet():void {
      r.requestAdapter = "js"
      r.initialized(null, null);
      JavaScriptClient(r.newRequestPipe());
    }

    /*
    public function testFindByID():void {
      Request finder = Resource.forName("post").finder();
      finder.addEventListener("result", addAsync(subjectMatches, 1000));

      finder.findFirst(1);
    }

    private function subjectMatches(post:*):void {
      assertEquals("This post was updated", post.subject);
    }
    
    public function testCreate():void {
      Request creator = Resource.forName("post").creator()
      creator.addEventListener("result", addAsync(postCreated, 1000));

      creator.create({subject: "test123", body: "Here is a new post created through Flails!", user_id: 1});
    }

    private var postCreated(post:*):void {
      assertTrue(post.id >= 1);
      assertEquals("test123", post.subject);
      assertEquals("Here is a new post created through Flails!", post.body);
    }
    
    public function testUpdate():void {
      Request updater = Resource.forName("post").updater()
      updater.addEventListener("result", addAsync(postUpdated, 1000));

      updater.update(1, {subject: "This post was updated", body: "Here is an existing post updated through Flails!"});
    }
    
    private var postUpdated(post:*):void {
      assertEquals("This post was updated", post.subject);
      assertEquals("Here is an existing post updated through Flails!", post.body);
    }
    
    public function testDestroy():void {
      //const PostResource:Resource = Resource.forName("post");
      //PostResource.addEventListener("result", addAsync(postCreated, 1000));
      //PostResource.addEventListener("result", addAsync(postDeleted, 1000));
    }

    private var postDeleted(post:*):void {
      assertEquals("This post was updated", post.subject);
      assertEquals("Here is an existing post updated through Flails!", post.body);
      }*/
  }
}

import flails.resource.Record;

dynamic class Post extends Record {
  public function Post(attributes:Object) {
    super(attributes);
  }
}
