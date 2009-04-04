package test.mxml {
  import net.digitalprimates.fluint.tests.TestCase;

  import mx.events.PropertyChangeEvent;

  import flails.resource.Record;
  import flails.resource.Resource;
  import flails.resource.Resources;
  import flails.mxml.Request;
  
  public class RequestTest extends TestCase {
    public var r:Request;
    public var resources:Resources;
    public var resource:Resource;

    override protected function setUp():void {
      resource = new Resource();
      resource.name = "posts";
      resource.initialized(null, null);

      resources = new Resources();
      resources.resources = [resource];
      resources.initialized(null, null);

      r = new Request();
      r.resourceName = "posts"
    }

/*    public function testIndex():void {
      r.type = "index";
      r.initialized(null, null);

      var remotePosts:Array = new Array;
      
      r.addEventListener("propertyChange", asyncHandler(function (e:PropertyChangeEvent, data:Object):void {
            var a:Array = e.newValue as Array;
            
            assertEquals(2, a.length);
            assertEquals(Record, a[0].constructor);
            assertEquals(Record, a[1].constructor);
          }, 5000));

      r.send();
    }

    public function testShow():void {
      r.type = "show";
      r.targetId = 1;
      r.initialized(null, null);

      var remotePosts:Array = new Array;
      
      r.addEventListener("propertyChange", asyncHandler(function (e:PropertyChangeEvent, data:Object):void {
            var r:Record = e.newValue as Record;

            assertEquals(r.subject, "testFindAll #1");
            assertEquals(r.body, "testFindAll #1 body");
          }, 1000));

      r.send();
    }*/

    
/*    public function testFindByID():void {
      Request finder = Resource.forName("post").finder();
      finder.addEventListener("result", addAsync(subjectMatches, 1000));

      finder.findFirst(1);
    }

    private function subjectMatches(post:*):void {
      assertEquals("This post was updated", post.subject);
    }*/
    
    public function testCreateWithID():void {
      r.type = "create"
      r.data = {id: 1, post: {subject: "test1234", body: "Here is a new post created through Flails!"}};
      r.initialized(null, null);
      
      r.addEventListener("propertyChange", asyncHandler(function (e:PropertyChangeEvent, data:Object):void {
            var r:Record = e.newValue as Record;

            assertEquals("test1234", r.subject);
            assertEquals("Here is a new post created through Flails!", r.body);
          }, 1000));

      r.send();
    }
    
    public function testCreateWithData():void {
      r.type = "create"
      r.data = {post: {subject: "test123", body: "Here is a new post created through Flails!"}};
      r.initialized(null, null);
      
      r.addEventListener("propertyChange", asyncHandler(function (e:PropertyChangeEvent, data:Object):void {
            var r:Record = e.newValue as Record;

            assertEquals("test123", r.subject);
            assertEquals("Here is a new post created through Flails!", r.body);
          }, 1000));

      r.send();
    }

/*    private var postCreated(post:*):void {
      assertTrue(post.id >= 1);
      assertEquals("test123", post.subject);
      assertEquals("Here is a new post created through Flails!", post.body);
    }*/
    
/*    
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
