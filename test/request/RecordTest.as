package test.request {
  
  import mx.controls.Alert;
  
  import flails.request.*;
  
  import net.digitalprimates.fluint.tests.TestCase;
  
  import flash.utils.*;
  
  public class RecordTest extends TestCase {
    public function testAttributes():void {
      var modelAttributes:Object = {body: "This post is getting updated again", id: 1, subject: "updated by testSave()", user_id: 1, account_id: 2}
      var modelObject:Record = new Record(modelAttributes);
      
      assertEquals("This post is getting updated again", modelObject["body"]);
      assertEquals("1", modelObject.id);
      assertEquals("updated by testSave()", modelObject.subject);
      assertEquals("1", modelObject.user_id);
      assertEquals("2", modelObject.account_id);
    }
    
/*    public function testAssignBelongsToAssociations():void {
      var modelAttributes:Object = {body: "This post is getting updated again", id: 1, subject: "updated by testSave()", user_id: 1, account_id: 2}
      var modelObject:Record = new Record("post", modelAttributes);
      
      assertEquals(2, modelObject.account.id);
      assertEquals(1, modelObject.user.id);
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