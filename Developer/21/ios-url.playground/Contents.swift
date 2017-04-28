//: Playground - noun: a place where people can play

import UIKit

URL(fileURLWithPath: "/Users/kofler/foto.jpg")
URL(string: "file:///Users/kofler/foto.jpg")
URL(string: "file:///Users/kofler/foto.jpg")!.path
URL(string: "file:///Users/kofler/foto.jpg")!.absoluteString

URL(fileURLWithPath: "/Users/kofler/name mit Leerzeichen und äöü.jgp").absoluteString

let url = URL(fileURLWithPath: "/Users/kofler/foto.jpg")
url.deletingPathExtension()
url.deletingLastPathComponent()
url.appendingPathExtension("bak")
url.lastPathComponent
url.deletingLastPathComponent()
  .appendingPathComponent("unterverzeichnis")
  .appendingPathComponent(url.lastPathComponent)

if (try? url.checkResourceIsReachable()) == true {
  print("Datei/Verzeichnis existiert")
}

// Documents-Verzeichnis ermitteln
let fm = FileManager.default
let urls = fm.urls(for: .documentDirectory,
                   in: .userDomainMask)
if let url = urls.first {
  print(url.path)
}

// Home-Verzeichnis ermitteln
NSHomeDirectory()

// so funktioniert es nicht, liefert nil
// (Documents-Verzeichnis ermitteln)
fm.urls(for: .userDirectory,
        in: .userDomainMask).first

// aktuelles Verzeichnis ermitteln (1)
let current = URL(fileURLWithPath: "")
print(current.path)

// aktuelles Verzeichnis ermitteln (2)
print(fm.currentDirectoryPath)

// aktuelles Verzeichnis ändern
if let url = urls.first {
  let ok = fm.changeCurrentDirectoryPath(url.path)
}


// temporäres Verzeichnis ermitteln
NSTemporaryDirectory()


