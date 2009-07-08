package test.clients {
  import net.digitalprimates.fluint.tests.TestCase;

  import mx.rpc.events.ResultEvent;

  import flails.clients.HTTPRailsClient;
  import flails.clients.HTTPClientBase;
  import flails.request.JSONFilter;
  
  public class HTTPRailsClientTest extends TestCase {
    public function testPost():void {
      var client:HTTPRailsClient = new HTTPRailsClient("http://localhost:3000/clients", 
                                                       new JSONFilter(), 
                                                       HTTPClientBase.METHOD_POST, 
                                                       asyncHandler(function (e:ResultEvent, data:Object):void {
                                                         assertEquals(e.result.var1, "processed-one");
                                                         assertEquals(e.result.var2, "processed-two");
                                                       }, 1500));

      client.send({test_object: {var1: "one", var2: "two"}});
    }
  }
}
