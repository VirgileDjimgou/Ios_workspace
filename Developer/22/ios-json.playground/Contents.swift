//: Playground - noun: a place where people can play

import UIKit

// Bundle-Datei lesen ...
if let url = Bundle.main.url(forResource: "sample",
                             withExtension: "json"),
   let data = try? Data(contentsOf: url),
   // ... und als JSON-Daten interpretieren
   let object = try?
         JSONSerialization.jsonObject(
            with: data,
            options: JSONSerialization.ReadingOptions()),
   let json = object as? [String: AnyObject]
{
  // Auswertung der JSON-Daten
  let menu = json["menu"] as! [String: AnyObject]
  let id = menu["id"] as! String
  print("id=\(id)")
  
  let value = menu["value"] as! String
  print("value=\(value)")
  
  let popup = menu["popup"] as! [String: AnyObject]
  let items = popup["menuitem"] as! [[String: String]]
  for item in items {
    let itemvalue = item["value"]
    let onclick = item["onclick"] 
    print("  value=\(itemvalue) -- onclick=\(onclick)")
  }
}
