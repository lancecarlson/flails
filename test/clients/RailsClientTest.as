package test.clients {
  import test.FlailsTest;
  import test.TestResponder;

  import flails.clients.RailsClient;
  import flails.clients.HTTPRequestMethod;
  import flails.request.Result;
  import flails.request.JSONFilter;
  
  public class RailsClientTest extends FlailsTest {
    public function testPost():void {
      var client:RailsClient = client("http://localhost:3000/clients", HTTPRequestMethod.POST, {test_object: {var1: "one", var2: "two"}});

      doTest(client.send(), function (result:Object):void {
        assertEquals(result.var1, "created-one");
        assertEquals(result.var2, "created-two");
      }, 1000);
    }

    public function testGet():void {
      var client:RailsClient = client("http://localhost:3000/clients", HTTPRequestMethod.GET, {test_object: {var1: "one", var2: "two"}});

      doTest(client.send(), function(result:Array):void {
        assertEquals(result[0].var1, "0-one");
        assertEquals(result[0].var2, "0-two");
        assertEquals(result[1].var1, "1-one");
        assertEquals(result[1].var2, "1-two");
      }, 1000);
    }

    public function testPut():void {
      var client:RailsClient = client("http://localhost:3000/clients/1", HTTPRequestMethod.PUT, {test_object: {var1: "one", var2: "two"}});

      doTest(client.send(), function (result:Object):void {
        assertEquals(result.id, "1");
        assertEquals(result.var1, "updated-one");
        assertEquals(result.var2, "updated-two");
      }, 1000);
    }

    public function testDelete():void {
      var client:RailsClient = client("http://localhost:3000/clients/100", HTTPRequestMethod.DELETE)
      
      doTest(client.send(), function (result:Object):void {
        assertEquals(result.id, "100");
        assertEquals(result.deleted, true);                                                         
      }, 1000);
    }

    protected function client(url:String, method:String, data:Object = null):RailsClient {
      var c:RailsClient = new RailsClient(url, method, data);
      
      c.result      = new Result(new JSONFilter().load);
      c.contentType = JSONFilter.CONTENT_TYPE;

      return c;
    }
  }
}
