package test.clients {
  import net.digitalprimates.fluint.tests.TestCase;

  import mx.rpc.events.ResultEvent;

  import flails.clients.JavaScriptClient;
  
  public class JavaScriptClientTest extends TestCase {
    public function testSendWithoutArguments():void {
      var client:JavaScriptClient = new JavaScriptClient("noArguments", asyncHandler(function(e:ResultEvent, data:Object):void {
        assertEquals("Yay! No arguments!", e.result);
      }, 1000));

      client.send();
    }

    public function testSendOneArgument():void {
      var client:JavaScriptClient = new JavaScriptClient("oneArgument", asyncHandler(function(e:ResultEvent, data:Object):void {
        assertEquals("The argument!", e.result);
      }, 1000));

      client.send("The argument!");
    }

    public function testSendManyArguments():void {
      var client:JavaScriptClient = new JavaScriptClient("manyArguments", asyncHandler(function(e:ResultEvent, data:Object):void {
        var expected:Array = ["arg1", "arg2", "arg3"];
        
        assertEquals(expected.length, e.result.length);
        for (var i:int = 0; i < e.result.length; i++)
          assertEquals(expected[i], e.result[i]);
      }, 1000));

      client.send("arg1", "arg2", "arg3");
    }
  }
}
