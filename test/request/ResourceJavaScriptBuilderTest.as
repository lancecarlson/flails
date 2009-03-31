package test.request {
  import net.digitalprimates.fluint.tests.TestCase;
  import flails.request.ResourceJavaScriptBuilder;
  
  public class ResourceJavaScriptBuilderTest extends TestCase {
    private var r:ResourceJavaScriptBuilder = new ResourceJavaScriptBuilder("users");
    
    public function testIndex():void {
      assertEquals("usersIndex", r.index())
    }
    
    public function testShow():void {
      assertEquals("usersShow", r.show(1))
    }
    
    public function testCreate():void {
      assertEquals("usersCreate", r.create())
    }
    
    public function testUpdate():void {
      assertEquals("usersUpdate", r.update(1))
    }
    
    public function testDestroy():void {
      assertEquals("usersDestroy", r.destroy(1))
    }
  }
}