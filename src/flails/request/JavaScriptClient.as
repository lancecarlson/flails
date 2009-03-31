/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package flails.request {
  import flash.events.EventDispatcher;
  import flash.events.Event;

  import flash.external.ExternalInterface;

  import mx.rpc.events.ResultEvent;

  //import com.adobe.serialization.json.*;
  
  public class JavaScriptClient extends EventDispatcher implements RequestPipe {
    private var errorHandler:Function;

    private var pathBuilder:PathBuilder;
    private var filter:Filter;
    
    public function JavaScriptClient(pathBuilder:PathBuilder, filter:Filter = null) {
      this.pathBuilder = pathBuilder;
      this.filter      = filter;
    }
    
    public function index():void {
      // ...
    }
    
    public function show(id:Number):void {
      trace("adding callback " + pathBuilder.show(id) + "Result");
      ExternalInterface.addCallback(pathBuilder.show(id) + "Result", onShowResponse);

      trace("calling " + pathBuilder.show(id));
      ExternalInterface.call(pathBuilder.show(id), id);
    }
    
    public function create(data:Object):void {
      //ExternalInterface.addCallback(pathBuilder.create() + "Result");
      //ExternalInterface.call(pathBuilder.create(), data);
    }

    public function update(id:Number, data:Object):void {
      // ...
    }
    
    public function destroy(id:Number):void {
      // ...
    }

    private function onShowResponse(data:Object):void {
      trace("called back with data: " + data);
      dispatchEvent(new ResultEvent("result", false, false, filter.load(data)));
    }
  }
}