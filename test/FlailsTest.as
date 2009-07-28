package test {
  import net.digitalprimates.fluint.tests.TestCase;

  import mx.rpc.IResponder;

  import flash.events.Event;
  import flash.net.URLLoader;
  import flash.net.URLRequest;

  import flails.clients.RailsClient;
  import flails.request.Result;
  
  public class FlailsTest extends TestCase {
    protected function doTest(result:Result, testHandler:Function, timeout:uint):void {
      result.completeHandler = testHandler;
      result.responder       = asyncResponder(new TestResponder(result.responder), 1000);
    }
  }
}