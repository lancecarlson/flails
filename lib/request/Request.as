package lib.request {
  import lib.json.*;
  
  import mx.controls.Alert;
  
  import mx.rpc.events.*;
  import mx.rpc.http.*;
  import flash.events.*;
  
  public class Request {
    public var resource:String;
    public var resourceID:uint;
    private var eventHandlers:Array = new Array;
    private var httpService:HTTPService = new HTTPService();
    
    public function Request(resource:String) {
      this.resource = resource;
    }
    
    public function dispatch():void {
      httpService.url = requestPath().fullPath();
      httpService.send();
    }
    
    public function cleanHandler(event:ResultEvent):void {
      var httpService:HTTPService = event.target as HTTPService;
      httpService.removeEventListener(event.type, this.resultHandler);
    }
    
    public function resultHandler(resultHandler:Function):void {
      addHandler(ResultEvent.RESULT, resultHandler);
    }
    
    public function faultHandler(faultHandler:Function):void {
      addHandler("fault", faultHandler);
    }
    
    private function addHandler(handlerType:String, handlerFunction:Function):void {
      httpService.addEventListener(handlerType, handlerFunction);
    }
    
/*    private function resultHandler(event:ResultEvent):void {     
      var httpService:HTTPService = event.target as HTTPService;
      httpService.removeEventListener(resultEvent, eventHandlers[resultEvent]);
      
      for each (var resultEvent:String in eventHandlers) {
      }
      
      Alert.show("bleh");
    }*/
    
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