/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package org.flails.request {
  
  import mx.controls.Alert;
  
  import org.flails.request.Model;
  
  dynamic public class ModelObject extends Object {
    
    public var type:String;
    
    public function ModelObject(type:String, attributes:Object=null) {
      this.type = type;
      
      if (attributes != null) {
        setAttributes(attributes);
        setBelongsToAssociations();
      }
    }
    
    public function setAttributes(attributes:Object):void {
      for(var key:String in attributes) {
        this[key] = attributes[key];
      }
    }
    
    public function model():Model {
      return new Model(type);
    }
    
    public function save():Request {
      return model().update(this.id, sanitized());
    }
    
    private function sanitized():ModelObject {
      var sanitizedModelObject:ModelObject = this;
      delete sanitizedModelObject["id"];
      deleteBelongsToAssociations(sanitizedModelObject);
      return sanitizedModelObject;
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
          return new Model(belongsToKey).findByID(this[belongsToKey + "_id"]);
        }
      });
    }
    
    
    private function deleteBelongsToAssociations(modelObject:ModelObject):ModelObject {
      belongsToKeys().forEach(function(belongsToKey:String, index:int, array:Array):void {
        delete modelObject[belongsToKey];
      });

      return modelObject;
    }
    


    
/*    public static function create(json:Object):Object {
      var type:String = findType(json);
      var modelObject:Object = json[type];
      
      modelObject = assignRequiredAttributes(modelObject, type);
      modelObject = assignFunctions(modelObject);
      modelObject = assignBelongsToAssociations(modelObject);

      return modelObject;
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