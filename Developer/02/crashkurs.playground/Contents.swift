//: Playground - noun: a place where people can play

import Cocoa

// Hinweis: Durch die Aufteilung des Codes in mehrere Gruppen
// mit if true  kann ich in mehreren Beispielen die gleichen
// Variablen deklarieren. Außerdem lässt sich der Code übersichtlich
// ein- und ausklappen.

// mehrzeilige Anweisungen
if true  {
  print("abc" +
    "efg")
  let a = 3
    + 5
  
  let temp = NSString(string: NSTemporaryDirectory())
    .appendingPathComponent("mein-temp-verzeichnis")
  
  // Fehler 'expecting member name following .'
  //let temp2 = NSString(string: NSTemporaryDirectory()).
  //  appendingPathComponent("mein-temp-verzeichnis")

  // mehrere Anweisungen in einer Zeile
  var x1 = 3; let x2 = 5; var x3 = x1 + x2
}

// erstes Closure-Beispiel
if true  {
  let data = [1, 2, 3, 4]  // Array
  let newdata = data.map() { $0+3 }
  print(newdata)  // [4, 5, 6, 7]
}

// elementare Datentypen
if true  {
  var x=3
  // x=2.5     // Fehler, x ist eine Integer-Variable!
  
  var y=2.5
  y=3
  
  let i=2
  // let sq = sqrt(i)          // Fehler, sqrt erwartet Double-Parameter
  let sq = sqrt(Double(i))     // OK
  
  var x1 = 3           // Int
  var x2 = 0.2         // Double
  // var x3 = x1 + x2  // Fehler, + kann Int und Double
                       // nicht addieren
  var x3 = Double(x1) + x2  // OK
  
  var x4 = 3 + 0.2  // funktioniert, weil der Compiler
                    // vorweg addiert
  
  var s = "Eine lange " +
          "Zeichenkette"

  var result=3*7
  print("result=\(result)")       // Ausgabe: result=21
  print("Die Wurzel von zwei ist \(sqrt(2))")
}

// Datentypen und Optionals
if true  {
  var d: Double = 3         // d ist eine Double-Variable
  
  var opt: Int? = 3
  opt = nil
  
  var nmb = Int("123")  // 123 (Datentyp 'Int?')
  print(nmb as Any)     // Ausgabe: Optional(123)
  nmb = Int("abc")      // nil
  if nmb != nil {
    print(nmb!)
  }
  
  // print(nmb + 3)          // nicht möglich
  // var i: Int = nmb        // nicht möglich
  
  if nmb != nil {
    print(nmb! + 3)       // ok
    let i: Int = nmb!      // ok
  }

  if let j = nmb {        // j hat den Datentyp Int
    print(j + 4)          // ok
  }


}

// Tupel, Arrays und Dictionaries
if true  {
  var tupel = (1, 2, 3, "abc", true)
  var coord3D = (3.3, 2.4, 0.7)
  var (x,y,z) = coord3D
  print(coord3D.2)    // Ausgabe 0.7
  
  var daten = [7, 12, 9]
  print(daten[1])        // 12, also das zweite Element
  let cnt = daten.count  // 3
  
  for i in daten {
    print(i)
  }

  var data = [2.4, 3.5]
  data.append(3.4)
  data+=[2.7, 3.9]
  data.remove(at: 2)
  print(data)  // Ausgabe: [2.4, 3.5, 2.7, 3.9]

  // 8x8-Integer-Array erzeugen und mit 0 initialisieren
  var chessboard =
    Array(repeating:
      Array(repeating: 0, count:8), count:8)
  
  var colorcodes = ["red":   0xff0000,
                    "green": 0x00ff00,
                    "blue":  0x0000ff]
  colorcodes["white"] = 0xffffff       // Element hinzufügen
  
  for (cname, cval) in colorcodes {  // Schleife über alle Elemente
    var hex = NSString(format:"%06X", cval)
    print("Farbcode \(hex) = Farbe \(cname)")
  }

  
}

// Schleifen
if true  {
  // for-in-Schleife (for-each)
  for  i in 1...3 {
    print(i)
  }
  
  // while-Schleife
  var cnt=1
  while cnt<4 {
    print(cnt)
    cnt += 1
  }
  
  // repeat-while-Schleife
  cnt=1
  repeat {
    print(cnt)
    cnt += 1
  } while cnt<4
}

// Verzweigungen
if true  {
  var x = Int(arc4random())
  if x<0 {
    print("x ist negativ")
  } else if x==0 {
    print("x ist 0")
  } else {
    print("x ist positiv")
  }

  let eingabe = "123"
  if let n = Int(eingabe) {
    print("Zweimal n = \(2*n)")
  }

  switch x {
  case 1:
    print("x ist 1")
  case 2, 3:
    print("x ist 2 oder 3")
  default:
    print("x ist kleiner 1 oder größer 3")
  }

}

// Funktionen und Closures
if true  {
  func avg(data: [Double]) -> Double {
    var sum = 0.0
    for itm in data {
      sum += itm
    }
    return sum / Double(data.count)
  }
  
  let x = [7.3, 2.5, 0.0]
  print("Durchschnittswert: \(avg(data: x))")
  
  // Funktion mit Parametern, deren Name beim
  // Aufruf nicht angegeben werden muss
  func sum(_ a: Int, _ b: Int) -> Int {
    return a + b
  }
  print(sum(7, 12))

  // applyFuncAndPrint wendet die Funktion fn auf alle Elemente
  // eines String-Arrays an und gibt das Ergebnis aus
  func applyFuncAndPrint(data: [String], fn: (String) -> String) {
    for s in data {
      print(fn(s))
    }
  }
  // liefert lauter Großbuchstaben
  func upper(s: String) -> String {
    return s.uppercased()
  }
  let ar = ["Swift", "ist", "cool"]
  applyFuncAndPrint(data: ar, fn: upper)  // Ausgabe: SWIFT IST COOL

  // Closure an applyFuncAndPrint übergeben
  applyFuncAndPrint(data: ar,
                    fn:{ (s:String) -> String in return s.lowercased() } )
  // Ausgabe: swift ist cool

  applyFuncAndPrint(data: ar,
                    fn:{ (s:String) -> String in
                      return String(s.characters.first!) } )
  // Ausgabe: s i c

  // Closure in Kurzschreibweise an applyFuncAndPrint übergeben
  applyFuncAndPrint(data: ar, fn:{ $0.lowercased() } )
  applyFuncAndPrint(data: ar, fn:{ String($0.characters.first!) } )

  // andere Syntaxvariante zum Closure-Aufruf
  applyFuncAndPrint(data: ar) { $0.lowercased() }
  applyFuncAndPrint(data: ar) { String($0.characters.first!) }

  
}

// Klassen und Strukturen
if true  {
  class Rectangle {
    var width:  Double
    var height: Double
    
    init(width: Double, height: Double) {
      self.width  = width
      self.height = height
    }
    func area() -> Double {
      return width * height
    }
    func showData() {
      print("Width  = \(width)")
      print("Height = \(height)")
      print("Area   = \(area())")
    }
  }
  
  // Anwendung der Klasse
  var rects = [Rectangle]() // Rectangle-Array
  rects += [Rectangle(width: 10,  height: 12)]
  rects += [Rectangle(width: 7.3, height: 2.4)]
  rects += [Rectangle(width: 2.9, height: 0.7)]
  for rect in rects {
    rect.showData()
  }

}

// Protokolle
if true  {
  class Rectangle : CustomStringConvertible {
    var width:  Double
    var height: Double
    
    init(width: Double, height: Double) {
      self.width  = width
      self.height = height
    }
    
    var description: String {
      return "w=\(width) h=\(height)"
    }
  }
  
  let r = Rectangle(width: 10, height: 5)
  print(r)  // Ausgabe "r=10.0 h=5.0"

}



// Fehlerabsicherung
if true  {
  let s = "Ein Text"
  // Zeichenkette s in eine Textdatei schreiben
  do {
    try s.write(toFile: "test.txt",
                atomically: true,
                encoding: .utf8)
  } catch {
    // hier steht automatisch die Konstante 'error'
    // zur Verfügung
    print("Fehler: \(error)")
    print()
    print("Die obige Fehlermeldung war zu erwarten. Aus einem Playground-")
    print("heraus können Sie aus Sicherheitsgründen keine Datei speichern.")
  }

}
