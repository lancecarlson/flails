package test.request {
  import mx.controls.Alert;
  import flash.events.*;
  import org.flails.request.*;
  
  import flexunit.framework.TestCase;
  
  public class ModelTest extends TestCase {
    
    public function testFindAll():void {
      const Post:Model = new Model("post");
      var request:Request = Post.findAll();
      request.onComplete(function(posts:*):void {
        posts.forEach(function(post:*, index:int, array:Array):void {
          Alert.show("several");
          Alert.show(post.subject);
        });
      });
      
      request.onError(function():void {
        Alert.show("Darn");
      })
      
      assertEquals("test", "test");
    }
    
    public function testFindByID():void {
      const Post:Model = new Model("post");
      var request:Request = Post.findByID(1);
      request.onComplete(function(post:*):void {
        Alert.show("one");
        Alert.show(post.subject);
      });
      
      request.onError(function():void {
        Alert.show("Darn");
      })
      
      assertEquals("test", "test");
    }
    
  }
}