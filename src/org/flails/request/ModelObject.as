/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package org.flails.request {
  
  import org.flails.request.Model;
  
  import mx.controls.Alert;
  
  public class ModelObject extends Object {
    
    public static function create(json:Object):Object {
      var type:String = findType(json);
      var modelObject:Object = json[type];
      
      modelObject = assignRequiredAttributes(modelObject, type);
      modelObject = assignFunctions(modelObject);
/*      modelObject = assignBelongsToAssociations(modelObject);*/

      return modelObject;
    }
    
    private static function assignRequiredAttributes(modelObject:Object, type:String):Object {
      modelObject._type = type;
      modelObject._model = new Model(type);
      return modelObject;
    }
    
    private static function assignFunctions(modelObject:Object):Object {
      modelObject.save = function():Request {
        return this._model.update(this.id, sanitizeObject(this));
      }
      return modelObject;
    }
    
    public static function getBelongsToKeys(modelObject:Object):Array {
      var belongsToKeys:Array = new Array;
      for (var key:String in modelObject) {
        var matches:Array = key.match(/^(.*)_id$/);
        if (matches != null) {
          belongsToKeys.push(String(matches[1]));
        }
      }
      return belongsToKeys;
    }
    
    public static function assignBelongsToAssociations(modelObject:Object):Object {
      getBelongsToKeys(modelObject).forEach(function(belongsToKey:String, index:int, array:Array):void {
        modelObject[belongsToKey] = function():Request {
          return new Model(belongsToKey).findByID(modelObject[belongsToKey + "_id"]);
        }
      });
      
      return modelObject;
    }
    
    public static function deleteBelongsToAssociations(modelObject:Object):Object {
      getBelongsToKeys(modelObject).forEach(function(belongsToKey:String, index:int, array:Array):void {
        delete modelObject[belongsToKey];
      });
      
      return modelObject;
    }
    
    private static function findType(json:Object):String {
      for (var key:String in json) { var type:String = key; }
      return key;
    }
    
    private static function sanitizeObject(unsanitized:Object):Object {
      delete unsanitized._type;
      delete unsanitized._model;
      delete unsanitized.save;
      
/*      unsanitized = deleteBelongsToAssociations(unsanitized);*/
      
      return unsanitized;
    }
    
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