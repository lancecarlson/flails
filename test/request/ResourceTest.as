package test.request {
  import mx.controls.Alert;
  import flash.events.*;
  import flails.request.*;
  
  import flexunit.framework.TestCase;
  
  public class ResourceTest extends TestCase {
    public function testInitializationWithClass():void {
      assertEquals("post", Resource.forClass(Post).resourceName)
    }
    
    public function testFindAll():void {
      var remotePosts:Array = new Array;
      remotePosts[0] = {subject: "Getting removed"};
      remotePosts[1] = {subject: "Getting removed"};
      remotePosts[2] = {subject: "Getting removed"};
      remotePosts[3] = {subject: "Getting removed"};
      remotePosts[4] = {subject: "Getting removed"};
      remotePosts[5] = {subject: "Getting removed"};
      remotePosts[6] = {subject: "test123"};
      remotePosts[7] = {subject: "My third post"};
      remotePosts[8] = {subject: "My second post"};
      remotePosts[9] = {subject: "This post was updated"};
      
      Request finder = Resource.forName("post").finder();
      finder.addEventListener("result", addAsync(subjectsMatch, 1000));

      finder.findAll();
    }

    private function subjectsMatch(posts:*):void {
      var i:uint = 0;
      
      posts.forEach(function(post:*, index:int, array:Array):void {
          assertEquals(remotePosts[i].subject, post.subject);
          i += 1;
        });
    }
    
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
    }
  }
}

import flails.request.Record;

class Post extends Record {
  public function Post(resourceName:String, resourceClass:Class) {
    super(resourceName, resourceClass);
  }
}
