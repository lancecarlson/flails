package test.clients {
  import net.digitalprimates.fluint.tests.TestCase;

  import mx.rpc.events.ResultEvent;

  import flails.clients.JavaScriptClient;

  import test.FlailsTest;
  
  public class JavaScriptClientTest extends FlailsTest {
    public function testSendWithoutArguments():void {
      doTest(new JavaScriptClient("noArguments").send(), function(data:Object):void {
        assertEquals("Yay! No arguments!", data);
      }, 1000);
    }

    public function testSendOneArgument():void {
      doTest(new JavaScriptClient("oneArgument").send("The argument!"), function(data:Object):void {
        assertEquals("The argument!", data);
      }, 1000);
    }

    public function testSendManyArguments():void {
      doTest(new JavaScriptClient("manyArguments").send("arg1", "arg2", "arg3"), function(data:Object):void {
        var expected:Array = ["arg1", "arg2", "arg3"];
        
        assertEquals(expected.length, data.length);

        for (var i:int = 0; i < data.length; i++)
          assertEquals(expected[i], data[i]);
      }, 1000);
    }
  }
}
