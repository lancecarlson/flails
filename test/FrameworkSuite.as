package test {
  import test.request.*
  import test.clients.*
  import test.resource.*
  import test.resource.mxml.*
   import net.digitalprimates.fluint.tests.TestSuite;

  public class FrameworkSuite extends TestSuite {
    public function FrameworkSuite() {
      addTestCase(new HTTPResourceTest());
      addTestCase(new JSONFilterTest());
      addTestCase(new HTTPRailsClientTest());
      addTestCase(new IdentityFilterTest());
      addTestCase(new ResourceInstantiationTest());
      addTestCase(new RecordTest());
      addTestCase(new ResourceJavaScriptBuilderTest());
    }
  }
}