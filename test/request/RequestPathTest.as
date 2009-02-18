package test.request {
  import flexunit.framework.TestCase;
  import lib.request.RequestPath;
  
  public class RequestPathTest extends TestCase {
    
    public function testFullPathWithAction():void {
      var requestPath:RequestPath = new RequestPath("user", "create");
      assertEquals("http://localhost:3000/users/create", requestPath.fullPath());
    }
    
    public function testFullPathWithActionAndID():void {
      var requestPath:RequestPath = new RequestPath("user", "blah", 1);
      assertEquals("http://localhost:3000/users/blah/1", requestPath.fullPath());
    }
    
    public function testFullPathWithID():void {
      var requestPath:RequestPath = new RequestPath("user", null, 1);
      assertEquals("http://localhost:3000/users/1", requestPath.fullPath());
    }
    
    public function testFullPathFindAll():void {
      var requestPath:RequestPath = new RequestPath("user");
      assertEquals("http://localhost:3000/users", requestPath.fullPath());
    } 
    
  }
}