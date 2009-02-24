package test.request {
  
  import mx.controls.Alert;
  
  import org.flails.request.*;
  
  import flexunit.framework.TestCase;
  
  public class ModelObjectTest extends TestCase {
    
/*    public function testGetBelongsToKeys():void {
      var modelObject:Object = {body: "This post is getting updated again", id: 1, subject: "updated by testSave()", user_id: 1, account_id: 2}
      var keys:Array = ModelObject.getBelongsToKeys(modelObject).sort();
      
      assertEquals("account", keys[0]);
      assertEquals("user", keys[1]);
      assertEquals(2, keys.length);
    }*/
    
/*    public function testAssignBelongsToAssociations():void {
      var modelObject:Object = {body: "This post is getting updated again", id: 1, subject: "updated by testSave()", user_id: 1, account_id: 2}
      var newModelObject:Object = ModelObject.assignBelongsToAssociations(modelObject);
      
      assertEquals(2, newModelObject.account.id);
      assertEquals(1, newModelObject.user.id);
    }*/
    
/*    public function testSave():void {
      const Post:Model = new Model("post");
      
      Post.findByID(1).onSuccess(function(post:*):void {
        post.subject = "updated by testSave()";
        post.body = "This post is getting updated again";
        post.save().onSuccess(function(updatedPost:*):void {
          assertEquals(post.subject, updatedPost.subject);
          assertEquals(post.body, updatedPost.body);
        });
      });
    }*/
  }
}