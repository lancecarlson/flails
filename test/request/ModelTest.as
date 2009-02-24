package test.request {
  import mx.controls.Alert;
  import flash.events.*;
  import org.flails.request.*;
  
  import flexunit.framework.TestCase;
  
  public class ModelTest extends TestCase {
    
/*    public function testFindAll():void {
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
      
      const Post:Model = new Model("post");
      Post.findAll().onSuccess(function(posts:*):void {
        var i:uint = 0;
        posts.forEach(function(post:*, index:int, array:Array):void {
          assertEquals(remotePosts[i].subject, post.subject);
          i += 1;
        });
      }).onError(function():void {
        Alert.show("something went wrong with testFindAll()");
      });
    }*/
    
    public function testFindByID():void {
      const Post:Model = new Model("post");
      Post.findByID(1).onSuccess(function(post:*):void {
        assertEquals("This post was updated", post.subject);
      }).onError(function():void {
        Alert.show("something went wrong with testFindByID()");
      });
    }
    
/*    public function testCreate():void {
      const Post:Model = new Model("post");
      Post.create({
        subject: "test123", 
        body: "Here is a new post created through Flails!", 
        user_id: 1}
      ).onSuccess(function(post:*):void {
        assertTrue(post.id >= 1);
        assertEquals("test123", post.subject);
        assertEquals("Here is a new post created through Flails!", post.body);
      }).onError(function():void {
        Alert.show("something went wrong with testCreate()");
      });
    }*/
    
/*    public function testUpdate():void {
      const Post:Model = new Model("post");
      Post.update(1, {
        subject: "This post was updated", 
        body: "Here is an existing post updated through Flails!"
      }).onSuccess(function(post:*):void {
        assertEquals("This post was updated", post.subject);
        assertEquals("Here is an existing post updated through Flails!", post.body);
      }).onError(function():void {
        Alert.show("Darn");
      })
    }*/
    
/*    public function testDestroy():void {
      const Post:Model = new Model("post");
      Post.create({
        subject: "Getting removed", 
        body: "This is getting removed", 
        user_id: 1}
      ).onSuccess(function(post:*):void {
        assertEquals("This is getting removed", post.body);
        Post.destroy(post.id).onSuccess(function():void {
          Post.findByID(post.id).onError(function():void {
            Alert.show("woot");
          })
        }).onError(function():void {
          Alert.show("problem deleting");
        });
      }).onError(function():void {
        Alert.show("darn!");
      });
    }*/
    
  }
}