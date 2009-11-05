package test {
  import test.request.*
  import test.clients.*
  import test.resource.*
  import test.resource.mxml.*
   import net.digitalprimates.fluint.tests.TestSuite;

  public class FrameworkSuite extends TestSuite {
    public function FrameworkSuite() {
      addTestCase(new ResourceTest());
      addTestCase(new ResultTest());
      addTestCase(new RailsResourceTest());
      addTestCase(new JSONFilterTest());
      addTestCase(new RailsClientTest());
      addTestCase(new JavaScriptClientTest());
      addTestCase(new RecordTest());
    }
  }
}