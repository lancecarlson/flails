/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package flails.request {
  import flash.events.EventDispatcher;
  import flash.events.Event;

  import flash.external.ExternalInterface;

  import mx.rpc.events.ResultEvent;

  public class JavaScriptClient extends EventDispatcher implements RequestPipe {
    private var errorHandler:Function;

    private var pathBuilder:PathBuilder;
    private var filter:Filter;
    
    public function JavaScriptClient(pathBuilder:PathBuilder, filter:Filter) {
      this.pathBuilder = pathBuilder;
      this.filter      = filter;
    }
    
    public function index(data:Object = null, ... parentIds):void {
      // ...
    }
    
    public function show(id:Object = null, data:Object = null, ... parentIds):void {
      trace("adding callback " + pathBuilder.show(id) + "Result");
      ExternalInterface.addCallback(pathBuilder.show(id) + "Result", onShowResponse);

      trace("calling " + pathBuilder.show(id));
      
      if (id != null)
        trace("(" + id.constructor + ")");
      else
        trace("(null)");

      ExternalInterface.call(pathBuilder.show(id), id);
    }
    
    public function create(data:Object = null, ... parentIds):void {
      //ExternalInterface.addCallback(pathBuilder.create() + "Result");
      //ExternalInterface.call(pathBuilder.create(), data);
    }

    public function update(id:Object = null, data:Object = null, ... parentIds):void {
      // ...
    }
    
    public function destroy(id:Object, data:Object = null, ... parentIds):void {
      // ...
    }

    private function onShowResponse(data:Object):void {
      trace("called back with data: " + data);

      dispatchEvent(new ResultEvent("result", false, false, filter.load(data)));
    }
  }
}
