package flails.resource {
  import flails.request.Result;

  public interface IResource {
    function index(data:Object = null):Result;

    function show(id:Object = null, data:Object = null):Result;

    function create(data:Object = null):Result

    function update(id:Object = null, data:Object = null):Result;

    function destroy(id:Object, data:Object = null):Result;
  }
}