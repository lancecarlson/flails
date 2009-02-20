/*package test.request {
  import mx.controls.Alert;
  import flash.events.*;
  import mx.rpc.events.*;
  import mx.rpc.http.*;
  import lib.request.*;
  
  import flexunit.framework.TestCase;
  
  public class RequestTest extends TestCase {
    
    public function testDispatch():void {
      var request:Request = new Request("post");      
      request.resultHandler(function(dataObject:*):void {
        Alert.show("test");
      });
      
      request.faultHandler(function():void {
        Alert.show("fault!");
      });
      
      assertEquals("I am not here", request.dispatch());
    }
    
  }
}*/