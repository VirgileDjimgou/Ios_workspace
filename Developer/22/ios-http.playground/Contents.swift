//: Playground - noun: a place where people can play

import UIKit

// Zeichenkette laden
var content: String = ""
let str = "https://kofler.info/uploads/tst.txt"
if let url = URL(string: str) {
  do {
    // zeigt in Playground Fehlermeldungen an (failed to obtain sandbox extension)
    // in einer »richtigen« App treten diese Fehler nicht auf, also einfach ignorieren
    content = try String(contentsOf: url)
    
    // Codierung der geladenen Seite ermitteln
    var enc = String.Encoding.ascii
    content = try String(contentsOf: url, usedEncoding: &enc)
    print(enc)
    
    // Codierung erzwingen
    content = try String(contentsOf: url,
                         encoding: String.Encoding.isoLatin1)
  } catch {
    // ok
    print(error.localizedDescription)
  }
}

// Bild laden
let iv = UIImageView(frame: CGRect(x:0, y:0, width: 600, height: 400))
let picurl = URL(string: "https://kofler.info/uploads/foto.jpg")!
do {
  let  bindata = try Data(contentsOf: picurl)
  iv.image = UIImage(data: bindata)
} catch {
  print(error.localizedDescription)
}
