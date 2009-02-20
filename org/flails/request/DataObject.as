package org.flails.request {
  
  import mx.controls.Alert;
  
  dynamic public class DataObject extends Object {
    
    public static function create(json:Object):DataObject {
      var type:String = findType(json);
      var dataObject:DataObject = new DataObject();
      
      return massageAttributes(dataObject, json[type]);
    }
    
    private static function findType(json:Object):String {
      var type:String;
      
      for (var key:String in json) {
        type = key;
      }
      
      return key;
    }
    
    private static function camelize(lowerCaseAndUnderscoredWord:String, firstLetterInUppercase:Boolean=true):String {
      var firstLetterLowerCase:String = lowerCaseAndUnderscoredWord.charAt(0).toLowerCase() + lowerCaseAndUnderscoredWord.slice(1);
      
      return firstLetterLowerCase.replace(/_(.)/g, function():String {
        return arguments[1].toUpperCase();
      });
    }
    
    private static function massageAttributes(dataObject:DataObject, attributes:Object):DataObject {
      for (var attribute:String in attributes) {
        dataObject[attribute] = attributes[attribute];
      }
      
      return dataObject;
    }
    
  }
}