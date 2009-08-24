package test {
  import test.request.*;
  import test.clients.*;
  import test.resource.*;
  import test.resource.mxml.*;
  import test.helpers.*;
  import net.digitalprimates.fluint.tests.TestSuite;

  public class FrameworkSuite extends TestSuite {
    public function FrameworkSuite() {
      addTestCase(new PaginatableCollectionTest());
      addTestCase(new IdentityMapTestFetchAndUpdate());
      addTestCase(new IdentityMapTestFetchAndUpdateArray());
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