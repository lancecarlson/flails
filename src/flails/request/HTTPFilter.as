package flails.request {
  public interface HTTPFilter extends Filter {
    function get contentType():String;

    function get extension():String;
  }
}