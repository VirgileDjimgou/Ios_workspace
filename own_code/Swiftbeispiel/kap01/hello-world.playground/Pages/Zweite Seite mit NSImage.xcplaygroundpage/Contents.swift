//: [Zurück zur vorigen Seite](@previous)

import Cocoa

let rect = NSRect(x: 0, y: 0, width: 600, height: 400)
let v = NSImageView(frame: rect)
let url = NSURL(string: "https://kofler.info/uploads/foto.jpg")
let pic = NSImage(contentsOfURL: url!)
v.image = pic

