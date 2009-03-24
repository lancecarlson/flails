package test.request {
  import net.digitalprimates.fluint.tests.TestCase;
  import flails.request.ResourcePathBuilder;
  
  public class ResourcePathBuilderTest extends TestCase {
    private var r:ResourcePathBuilder = new ResourcePathBuilder("users");
    
    public function testIndex():void {
      assertEquals("/users.json", r.index())
    }
    
    public function testShow():void {
      assertEquals("/users/1.json", r.show(1))
    }
    
    public function testCreate():void {
      assertEquals("/users.json", r.create())
    }
    
    public function testUpdate():void {
      assertEquals("/users/1.json", r.update(1))
    }
    
    public function testDestroy():void {
      assertEquals("/users/1.json", r.destroy(1))
    }
  }
}