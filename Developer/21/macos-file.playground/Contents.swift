//: Playground - noun: a place where people can play

import Cocoa

let fm = FileManager.default

// Eigenschaften einer Datei ermitteln
let path = "/Users/kofler/foto.jpg"

// testen, ob Datei existiert
if fm.fileExists(atPath: path) {
  print("Die Datei existiert.")

  if fm.isReadableFile(atPath: path) {
    print("Die Datei kann gelesen werden.")
  }
  if fm.isWritableFile(atPath: path) {
    print("Die Datei kann verändert werden.")
  }
  if fm.isDeletableFile(atPath: path) {
    print("Die Datei kann gelöscht werden.")
  }
  
  // Größe
  if let attr = try? fm.attributesOfItem(atPath: path) {
    if let nmb = attr[.size] as? NSNumber  {
      let size = nmb.int64Value
      print("Dateigröße: \(size) Byte")
    }
  }
}




// testen, ob es ein Verzeichnis ist
let dirpath = "/Users/kofler/subdir"
var isDir : ObjCBool = false
if fm.fileExists(atPath: dirpath,
                 isDirectory: &isDir),
  isDir.boolValue == true
{
  print("Es ist ein Verzeichnis.")
}

// Textdatei mit Backup speichern
let txt = "Zeile 1\nZeile 2 äöü\nZeile 3\n"
let docurl = fm.urls(for: .documentDirectory,
                     in: .userDomainMask).first!
let myfile =   docurl.appendingPathComponent("myfile123.txt")
let mybackup = docurl.appendingPathComponent("myfile123.bak")
let mycopy =   docurl.appendingPathComponent("myfile123.duplicate")

do {
  // gibt es schon ein Backup? --> löschen
  if fm.fileExists(atPath: mybackup.path) {
    try fm.removeItem(at: mybackup)
  }
  
  // gibt es die Zieldatei schon? --> umbenennen
  if fm.fileExists(atPath: myfile.path) {
    try fm.moveItem(at: myfile, to: mybackup)
  }
  
  // neue Datei speichern
  try txt.write(toFile: myfile.path,
                atomically: true,
                encoding: .utf8)

  // Datei in neue Variable wieder einlesen
  var enc: String.Encoding = .ascii // muss irgendwie initialisiert werden
  let newtxt = try String(contentsOfFile: myfile.path,
                          usedEncoding: &enc)
  print(enc.description)
  // zeilenweises Array bilden
  let lines = txt.characters
    .split() {$0 == "\n"}
    .map { String($0) }

  
  // Kopie der Datei erzeugen
  // (sobald der Playground zum zweiten Mal ausgeführt wird,
  //  tritt hier ein Fehler auf weil 'myfile.duplicate'
  //  bereits existiert)
  try fm.copyItem(at: myfile, to: mycopy)
} catch {
  // print(error.localizedDescription)
}





