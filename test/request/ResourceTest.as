package test.request {
  import net.digitalprimates.fluint.tests.TestCase;

  import mx.rpc.events.ResultEvent;

  import flails.request.HTTPClient;
  import flails.request.RequestPipe;
  import flails.request.Resource;
  
  public class ResourceTest extends TestCase {
    public function testInitializationWithClass():void {
      assertEquals("post", Resource.forClass(Post).resourceName)
    }
    
    public function testIndex():void {
      var remotePosts:Array = new Array;
      
      var pipe:RequestPipe = Resource.forClass(Post).requestPipe();
      pipe.addEventListener("result", asyncHandler(function (e:ResultEvent, data:Object):void {
            var a:Array = e.result as Array;

            assertEquals(2, a.length);
            assertEquals(Post, a[0].constructor);
            assertEquals(Post, a[1].constructor);
      }, 1000));

      pipe.index();
    }

    public function testShow():void {
      var remotePosts:Array = new Array;
      
      var pipe:RequestPipe = Resource.forClass(Post).requestPipe();
      pipe.addEventListener("result", asyncHandler(function (e:ResultEvent, data:Object):void {
            var p:Post = e.result as Post;
      }, 1000));

      pipe.show(1);
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

import flails.request.Record;

dynamic class Post extends Record {
  public function Post(attributes:Object) {
    super(attributes);
  }
}
