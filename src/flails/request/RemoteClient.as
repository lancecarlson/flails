/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

/*
Client does not handle status codes over 200 because of flash and URLLoader. Therefore, all validation 
errors or NotFound errors need to be sent back with a 200 status code. Whenever an exception is raised, 
an IOError is fired which is automatically handled by the framework to Alert that there was a problem. 

Check this for details: 

http://stackoverflow.com/questions/188887/how-to-access-as3-urlloader-return-data-on-ioerrorevent
*/
package flails.request {
  
  import flash.events.EventDispatcher;
  import flash.events.Event;
  
  import mx.rpc.remoting.RemoteObject;
  import mx.rpc.events.ResultEvent;
  
  import flails.request.PathBuilder;
  
  import mx.controls.Alert;
  
  public class RemoteClient extends EventDispatcher implements RequestPipe {
    public var data:Object;
    private var pathBuilder:PathBuilder;
    
    public function RemoteClient(pathBuilder:PathBuilder, filter:Filter = null) {
      this.pathBuilder = pathBuilder;
    }
    
    public function index():void {
      trace("entered index");
      
      doRemote(pathBuilder.index());
    }
    
    public function show(id:Object = null):void {
      doRemote(pathBuilder.show(id));
    }
    
    public function create(data:Object, id:Object = null):void {
/*      pushParams(data, "POST");*/
      
      doRemote(pathBuilder.create());
    }

    public function update(data:Object, id:Object):void {
/*      pushParams(data, "PUT");*/

      doRemote(pathBuilder.update(id));
    }
    
    public function destroy(id:Object):void {
/*      pushParams({}, "DELETE");*/
      
      doRemote(pathBuilder.destroy(id));
    }

/*    private function pushParams(params:Object, method:String):void {
      var variables:URLVariables = new URLVariables();
      
      if (method == "PUT" || method == "DELETE") {
        variables["_method"] = method.toLowerCase();
      }

      // replace this with filter.dump(params). Make ARSON filter take care of the resource[param] concatenation
      paramsToVariables(variables, params);

      request.data = variables;
    }
    
    private function paramsToVariables(variables:URLVariables, params:Object, prefix:String = null):void {
      for (var param:String in params) {
        var name:String;

        if (prefix) {
          name = prefix + "[" + param + "]";
        } else {
          name = param;
        }

        if (!(params[param] is String) && !(params[param] is Number)) {
          paramsToVariables(variables, params[param], name);
        } else {
          variables[name] = params[param];
        }
      }
    }

    private function onComplete(event:Event):void {      
      var response:URLLoader = URLLoader(event.target);
      
      if (response.data.replace(" ", "").length != 0) {
        dispatchEvent(new ResultEvent("result", false, false, filter.load(response.data)));
      } else {
        dispatchEvent(new ResultEvent("result"));
      }
    }

    private function addHeader(name:String, value:String):void {
      request.requestHeaders.push(new URLRequestHeader(name, value));
    }
    
    public function doGet(url:String):void {
      addHeader("Content-Type", "application/json");

      request.url = url;
      
      loader.addEventListener("complete", onComplete);
      loader.load(request);
    }*/
    
    public function doRemote(url:String):void {
      var remoteObject:RemoteObject = new RemoteObject;
      remoteObject.endpoint = "http://localhost:3000/rubyamf_gateway";
      remoteObject.source = "PostsController";
      remoteObject.destination = "rubyamf";
      remoteObject.index();
      remoteObject.addEventListener("result", function():void {
        Alert.show("test");
      })
      remoteObject.index();
    }
  }
}