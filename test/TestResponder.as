package test {
  import mx.rpc.IResponder;
  import net.digitalprimates.fluint.async.ITestResponder;

  public class TestResponder implements ITestResponder {
    private var responder:IResponder;

    public function TestResponder(realResponder:IResponder) {
      responder = realResponder;
    }
    
    public function fault(info:Object, passThroughData:Object):void {
      responder.fault(info);
    }

    public function result(data:Object, passThroughData:Object):void {
      responder.result(data);
    }
  }
}