/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package flails.resource {
  
  import flash.events.EventDispatcher;
  
  dynamic public class Record extends EventDispatcher {
    public function Record(attributes:Object=null) {
      if (attributes != null) {
        setAttributes(attributes);
      }
    }

    public function setAttributes(attributes:Object):Record {

      for (var key:String in attributes) {
        this[key] = attributes[key];
      }

      return this;
    }
    
    /*    public function resource():Resource {
      return new Resource(type, this.constructor);
      }
    
    public function save():Request {
      return resource().update(this.id, sanitized());
    }
    
    private function sanitized():Record {
      var sanitizedRecord:Record = this;
      delete sanitizedRecord["id"];
      deleteBelongsToAssociations(sanitizedRecord);
      return sanitizedRecord;
    }
    
    private function belongsToKeys():Array {
      var belongsToKeys:Array = new Array;
      for (var key:String in this) {
        var matches:Array = key.match(/^(.*)_id$/);
        if (matches != null) {
          belongsToKeys.push(String(matches[1]));
        }
      }
      return belongsToKeys;
    }
    
    private function setBelongsToAssociations():void {
      belongsToKeys().forEach(function(belongsToKey:String, index:int, array:Array):void {
        this[belongsToKey] = function():Request {
          return Resource.forName(belongsToKey).findByID(this[belongsToKey + "_id"]);
        }
      });
    }
    
    
    private function deleteBelongsToAssociations(record:Record):Record {
      belongsToKeys().forEach(function(belongsToKey:String, index:int, array:Array):void {
        delete record[belongsToKey];
      });

      return record;
    }
    */


    
/*    public static function create(json:Object):Object {
      var type:String = findType(json);
      var record:Object = json[type];
      
      record = assignRequiredAttributes(record, type);
      record = assignFunctions(record);
      record = assignBelongsToAssociations(record);

      return record;
    }*/
     

     



/*    private static function sanitizeObject(unsanitized:Object):Object {
      delete unsanitized._type;
      delete unsanitized._model;
      delete unsanitized.save;
      
      unsanitized = deleteBelongsToAssociations(unsanitized);
      
      return unsanitized;
    }
    */
/*    private static function camelize(lowerCaseAndUnderscoredWord:String):String {
      var firstLetterLowerCase:String = lowerCaseAndUnderscoredWord.charAt(0).toLowerCase() + lowerCaseAndUnderscoredWord.slice(1);
      
      return firstLetterLowerCase.replace(/_(.)/g, function():String {
        return arguments[1].toUpperCase();
      });
    }*/
    
/*    public function updateAttributes(attributes:Object):Request {
      return this["model"].update(this["id"], attributes);
        return new Request("post");
    }*/
    
  }
}