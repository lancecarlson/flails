package test.resource.mxml {
  import mx.rpc.events.ResultEvent;

  import flails.resource.mxml.Resource;
  import flails.resource.RailsResource;
  import flails.resource.JavaScriptResource;

  import test.FlailsTest;

  public class ResourceTest extends FlailsTest {
    private var resource:Resource;

    override protected function setUp():void {
      resource = new Resource();
    }

    public function testInstantiatesJavaScriptResource():void {
      resource.type = 'javascript';

      resource.initialized(null, null);

      assertEquals(resource.resource['constructor'], JavaScriptResource);
    }

    public function testInstantiatesRailsResource():void {
      resource.type = 'rails';

      resource.initialized(null, null);

      assertEquals(resource.resource['constructor'], RailsResource);
    }

    public function testProxiesSettings():void {
      resource.quack = 'duck';
      resource.moo   = 'cow';

      assertEquals('duck', resource.config.quack);
      assertEquals('cow', resource.config.moo);
    }
  }
}
