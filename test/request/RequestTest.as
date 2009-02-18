package test.request {
  import flash.events.Event;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import lib.request.*;
  
  import flexunit.framework.TestCase;
  
  public class RequestTest extends TestCase {
    
    public function testDispatch():void {
      var request:Request = new Request("post");
      var resultHandler:Function = new Function();
      
      assertEquals("I am not here", request.dispatch(resultHandler));
    }
    
  }
}