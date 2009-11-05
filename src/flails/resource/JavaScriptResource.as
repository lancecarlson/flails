/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
package flails.resource {
  import flash.events.EventDispatcher;

  import flails.request.ResourceJavaScriptBuilder;
  import flails.clients.JavaScriptClient;
  import flails.request.Result;

  import mx.utils.ObjectUtil;

  public class JavaScriptResource extends AbstractResource {
    private var pathBuilder:ResourceJavaScriptBuilder;
    
    public function JavaScriptResource(config:Object) {
      pathBuilder = new ResourceJavaScriptBuilder(config.name);
    }

    override public function show(id:Object = null, data:Object = null):Result {
      return new JavaScriptClient(pathBuilder.show()).send(id, data);
    }
  }
}