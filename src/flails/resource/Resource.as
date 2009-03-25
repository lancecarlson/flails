/**
 * Copyright (c) 2009 Lance Carlson
 * See LICENSE for full license information.
 */

package flails.resource {
  import flails.request.RequestPipe;
  import flails.request.HTTPClient;
  import flails.request.ResourcePathBuilder;
  import flails.request.JSONFilter;

  import flash.utils.getQualifiedClassName;
  
  public class Resource {
    public static function forName(resourceName:String):Resource {
      return new Resource(resourceName, Record);
    }

    public static function forClass(recordClass:Class):Resource {
      return new Resource(getQualifiedClassName(recordClass).split("::")[1].toLowerCase(), recordClass);
    }

    public var resourceName:String;
    public var recordClass:Class;
    
    public function Resource(resourceName:String, recordClass:Class) {
      this.resourceName = resourceName;
      this.recordClass  = recordClass;
    }
    
    public function requestPipe():RequestPipe {
      // TODO: The pluralization obviously needs to be taken care of
      return new HTTPClient(new ResourcePathBuilder(resourceName + "s"), new JSONFilter(recordClass));
    }
  }
}