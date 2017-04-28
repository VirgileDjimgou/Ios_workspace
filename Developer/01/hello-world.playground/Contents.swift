//: Playground - noun: a place where people can play

import Cocoa

//: Kommentar in **fetter** und *kursiver* Schrift

/*: 
 Ein mehrzeiliger Kommentar mit einer Aufzählung:
 
 * erstens
 * zweitens
 * drittens
 
*/

print("Hello World")


for i in 1...10 {
  print(i)
}

for x in 1...100 {
  let y = sin(Double(x)/10)
  print("x=\(x), y=\(y)")
}


let rect = NSRect(x: 0, y: 0, width: 600, height: 400)
let v    = NSImageView(frame: rect)
let url  = URL(string: "https://kofler.info/uploads/foto.jpg")
let pic  = NSImage(contentsOf: url!)
v.image  = pic
