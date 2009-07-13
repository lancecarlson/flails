/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */
package flails.resource.mxml {
  import flash.events.EventDispatcher;

  import flails.resource.ResourceBase;
  import flails.request.JSONFilter;
  import flails.request.ResourcePathBuilder;
  import flails.clients.RailsClient;
  import flails.request.HTTPFilter;
  import flails.clients.HTTPClientBase;

  public class RailsResource extends ResourceBase {

    public var baseURL:String;

    private var filter:HTTPFilter;
    private var pathBuilder:ResourcePathBuilder;
    
    override public function initialized(parent:Object, id:String):void {
      super.initialized(parent, id);

      filter      = new JSONFilter();
      pathBuilder = new ResourcePathBuilder(baseURL, name, filter.extension);
    }

    override public function index(data:Object = null, completeHandler:Function = null, errorHandler:Function = null):void {
      new RailsClient(pathBuilder.index(), filter, HTTPClientBase.METHOD_GET, completeHandler, errorHandler).send(data);
    }

    override public function show(id:Object = null, data:Object = null, completeHandler:Function = null, errorHandler:Function = null):void {
      new RailsClient(pathBuilder.show(id), filter, HTTPClientBase.METHOD_GET, completeHandler, errorHandler).send(data);
    }

    override public function create(data:Object = null, completeHandler:Function = null, errorHandler:Function = null):void {
      new RailsClient(pathBuilder.create(), filter, HTTPClientBase.METHOD_POST, completeHandler, errorHandler).send(data);
    }

    override public function update(id:Object = null, data:Object = null, completeHandler:Function = null, errorHandler:Function = null):void {
      new RailsClient(pathBuilder.update(id), filter, HTTPClientBase.METHOD_PUT, completeHandler, errorHandler).send(data);
    }

    override public function destroy(id:Object, data:Object = null, completeHandler:Function = null, errorHandler:Function = null):void {
      new RailsClient(pathBuilder.destroy(id), filter, HTTPClientBase.METHOD_DELETE, completeHandler, errorHandler).send(data);
    }
  }
}