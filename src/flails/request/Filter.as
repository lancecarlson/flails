package flails.request {
  public interface Filter {
    function load(data:String):Object;

    // Takes an object, turns that into a flat hash that will then be used by the RequestPipe
    function dump(data:Object):Object;
  }
}