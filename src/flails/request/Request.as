package flails.request {
  public interface Request {
    function findAll():void;

    function findFirst(query:Object):void;

    function create(query:Object):void;

    function update(data:Object):void;

    function destroy(data:Object):void;
  }
}