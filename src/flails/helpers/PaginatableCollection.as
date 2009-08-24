package flails.helpers {
  import mx.collections.ArrayCollection;
  import mx.events.PropertyChangeEvent;
  
  public class PaginatableCollection extends ArrayCollection {
    public var updateThreshold:Number;
    public var fetchMoreResults:Function;

    // TODO: add an update queue?
    private var updateInProgress:Boolean = false;

    public function PaginatableCollection() {
      addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, waitingForUpdate);
    }
  
    override public function getItemAt(index:int, prefetch:int = 0):Object {
      if (index >= length * updateThreshold && !updateInProgress) {
        updateInProgress = true;
        
        fetchMoreResults(this);
      }

      return super.getItemAt(index, prefetch);
    }

    private function waitingForUpdate(e:PropertyChangeEvent):void {
      if (e.property == "source") {
            updateInProgress = false;
      }
    }
  }
}