/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
package flails.resource.mxml {
  import flash.events.EventDispatcher;

  import flails.resource.Resource;
  import flails.request.ResourceJavaScriptBuilder;
  import flails.clients.JavaScriptClient;
  import flails.request.HTTPFilter;
  import flails.clients.HTTPClientBase;
  import flails.request.RequestConfig;
  import flails.request.Result;

  import mx.utils.ObjectUtil;

  public class JavaScriptResource extends Resource {
    private var pathBuilder:ResourceJavaScriptBuilder;
    
    override public function initialized(parent:Object, id:String):void {
      super.initialized(parent, id);

      pathBuilder = new ResourceJavaScriptBuilder(name);
    }

    override public function show(id:Object = null, data:Object = null, completeHandler:Function = null):Result {
      return new JavaScriptClient(pathBuilder.show()).send(id, data);
    }
  }
}