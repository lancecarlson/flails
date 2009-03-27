/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package flails.resource {
  import flails.request.RequestPipe;
  import flails.request.HTTPClient;
  import flails.request.ResourcePathBuilder;
  import flails.request.JSONFilter;

  import mx.core.IMXMLObject;

  public class Resource implements IMXMLObject {
    public var name:String;
    public var instanceClass:Class;
    
    public function Resource() {}
    
    public function initialized(parent:Object, id:String):void {
      if (name == null) throw new Error("Name not set for resource.");
      if (instanceClass == null) instanceClass = Record;
    }

    public function index(resultHandler:Function, errorHandler:Function = null):void {
      requestPipe(resultHandler, errorHandler).index();
    }

    public function show(id:Number, resultHandler:Function, errorHandler:Function = null):void {
      requestPipe(resultHandler, errorHandler).show(id);
    }

    public function requestPipe(resultHandler:Function, errorHandler:Function):RequestPipe {
      // TODO: The pluralization obviously needs to be taken care of
      var pipe:RequestPipe = new HTTPClient(new ResourcePathBuilder(name), new JSONFilter(instanceClass));

      pipe.addEventListener("result", resultHandler);

      return pipe;
    }
  }
}
