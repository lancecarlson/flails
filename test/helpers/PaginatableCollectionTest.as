package test.helpers {
  import flails.helpers.PaginatableCollection;

  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.utils.Timer;

  import test.FlailsTest;

  import mx.events.PropertyChangeEvent;

  public class PaginatableCollectionTest extends FlailsTest {
    private var p:PaginatableCollection;

    override protected function setUp():void {
      p = new PaginatableCollection();

      p.updateThreshold = 0.8;
      p.source          = new Array(10);
      p.fetchMoreResults = resultFunction;
    }

    public function testDontRefresh_beforeThreshold():void {
      p.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, failHandler);

      p.getItemAt(0);
    }

    public function testDontRefresh_atThresholdEdge():void {
      p.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, failHandler);

      p.getItemAt(7);
    }
    
    public function testRefresh_atThresholdEdge():void {
      p.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, yayHandler);

      p.getItemAt(8);
    }

    public function testRefresh_afterThreshold():void {
      p.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, yayHandler);

      p.getItemAt(10);
    }

    public function testRefresh_onlyOneRefreshAtATime():void {
      var firstCall:Boolean = true;
      p.updateThreshold  = 0.5;
      p.fetchMoreResults = function(c:PaginatableCollection):void {
        if (firstCall) {
          firstCall = false;

          var t:Timer = new Timer(500);
          
          t.addEventListener(TimerEvent.TIMER, function(e:Event):void {});
          
          t.start();
        } else {
          fail("NOOOO!!");
        }
      }

      p.getItemAt(5);
      p.getItemAt(5);
    }

    private function failHandler():Function {
      return asyncHandler(function(e:PropertyChangeEvent, data:Object):void {
        fail("NOOOOOO!!!");
      }, 500);
    }

    private function yayHandler():Function {
      return asyncHandler(function(e:PropertyChangeEvent, data:Object):void {
        assertEquals(20, e.newValue);
      }, 500);
    }

    private function resultFunction(c:PaginatableCollection):void {
      c.source = c.source.concat(new Array(10));
    }
  }
}
