package test {
  import test.request.*
  import test.resource.*
  import net.digitalprimates.fluint.tests.TestSuite;

  public class FrameworkSuite extends TestSuite {
    public function FrameworkSuite() {
      addTestCase(new ResourcePathBuilderTest());
      addTestCase(new HTTPClientTest());
      addTestCase(new JSONFilterTest());
      addTestCase(new IdentityFilterTest());
      addTestCase(new ResourceTest());
      addTestCase(new ResourceInstantiationTest());
      addTestCase(new RecordTest());
      addTestCase(new ResourceJavaScriptBuilderTest());
    }
  }
}