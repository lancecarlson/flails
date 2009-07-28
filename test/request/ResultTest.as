package test.request {
  import net.digitalprimates.fluint.tests.TestCase;

  import flails.request.Result;
  import flails.request.JSONFilter;
  import flails.request.IdentityFilter;

  import mx.events.PropertyChangeEvent;

  public class ResultTest extends TestCase {
    public function testBinding():void {
      var r:Result = new Result(new IdentityFilter());

      r.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, asyncHandler(function(e:PropertyChangeEvent, data:Object):void {
        assertEquals(3, e.newValue);
      }, 1000));

      r.result = 3;
    }
  }
}