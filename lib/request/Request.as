package lib.request {
  import lib.json.*;
  
  import mx.controls.Alert;
  
  import mx.rpc.events.*;
  import mx.rpc.http.*;
  import flash.events.*;
  
  public class Request {
    public var resource:String;
    public var resourceID:uint;
    
    public function Request(resource:String) {
      this.resource = resource;
    }
    
    public function dispatch(resultHandler:Function):void {
      var httpService:HTTPService = new HTTPService();
      
      httpService.url = requestPath().fullPath();
      
      //you need to tell the service who's listening     
      httpService.addEventListener(ResultEvent.RESULT, resultHandler);     
      httpService.send();
    }
    
    private function resultHandler(event:ResultEvent):void {     
      var httpService:HTTPService = event.target as HTTPService;     
      
      //don't forget to stop listening. we don't want memory leaks!     
      httpService.removeEventListener(ResultEvent.RESULT, resultHandler);  
    }
    
    private function requestPath():RequestPath {
      return new RequestPath(this.resource, null, this.resourceID);
    }
    
    private function decodeJSON():void {
      var jsonString:String = String("{\"user\": {\"name\": \"Lancelot\", \"updated_at\": \"2009-02-13T00:37:35Z\", \"social_id\": null, \"id\": 1, \"avatar_id\": null, \"credits\": 0, \"listening_to\": null, \"email\": null, \"created_at\": \"2009-02-13T00:37:35Z\"}}");
      var j:Object = JSON.decode(jsonString);
      for (var i:Object in j) {
    	  trace(j[i].name);
      }
    }
    
  }
}