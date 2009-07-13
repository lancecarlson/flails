package test.clients {
  import net.digitalprimates.fluint.tests.TestCase;

  import mx.rpc.events.ResultEvent;

  import flails.clients.RailsClient;
  import flails.clients.HTTPClientBase;
  import flails.request.JSONFilter;
  
  public class RailsClientTest extends TestCase {
    public function testPost():void {
      var client:RailsClient = new RailsClient("http://localhost:3000/clients", 
                                                       new JSONFilter(), 
                                                       HTTPClientBase.METHOD_POST, 
                                                       asyncHandler(function (e:ResultEvent, data:Object):void {
                                                         assertEquals(e.result.var1, "created-one");
                                                         assertEquals(e.result.var2, "created-two");
                                                       }, 1500));

      client.send({test_object: {var1: "one", var2: "two"}});
    }

    public function testGet():void {
      var client:RailsClient = new RailsClient("http://localhost:3000/clients", 
                                                       new JSONFilter(), 
                                                       HTTPClientBase.METHOD_GET, 
                                                       asyncHandler(function (e:ResultEvent, data:Object):void {
                                                         assertEquals(e.result[0].var1, "0-one");
                                                         assertEquals(e.result[0].var2, "0-two");
                                                         assertEquals(e.result[1].var1, "1-one");
                                                         assertEquals(e.result[1].var2, "1-two");
                                                       }, 1500));

      client.send({test_object: {var1: "one", var2: "two"}});
    }

    public function testPut():void {
      var client:RailsClient = new RailsClient("http://localhost:3000/clients/1", 
                                                       new JSONFilter(), 
                                                       HTTPClientBase.METHOD_PUT, 
                                                       asyncHandler(function (e:ResultEvent, data:Object):void {
                                                         assertEquals(e.result.id, "1");
                                                         assertEquals(e.result.var1, "updated-one");
                                                         assertEquals(e.result.var2, "updated-two");
                                                       }, 1500));

      client.send({test_object: {var1: "one", var2: "two"}});
    }

    public function testDelete():void {
      var client:RailsClient = new RailsClient("http://localhost:3000/clients/100", 
                                                       new JSONFilter(), 
                                                       HTTPClientBase.METHOD_DELETE, 
                                                       asyncHandler(function (e:ResultEvent, data:Object):void {
                                                         assertEquals(e.result.id, "100");
                                                         assertEquals(e.result.deleted, true);                                                         
                                                       }, 1500));

      client.send();
    }
  }
}
