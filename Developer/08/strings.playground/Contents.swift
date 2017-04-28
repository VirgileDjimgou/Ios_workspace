//: Playground - noun: a place where people can play

import UIKit

let s1 = "abc"          // Datentyp String
let s2 = "a"            // ebenfalls Datentyp String
let c: Character = "a"  // Datentyp Character

var s3 = s1 + s2 + "xxx"  // "abcaxxx"
s3 += "yz"                // "abcaxxxyz"
s3.isEmpty                // false

let s4 = String()                           // ""
let s5 = String(127, radix:16)              // "7f"
let s6 = String(repeating: "*-", count: 3)  // "*-*-*-"
let s7 = String(format:"%.2f", sqrt(2.0))   // "1.41"


// let longMsg = "Zeile 1
// Zeile 2"                    // Fehler
let longMsg = "Zeile 1\n" +
              "Zeile 2"        // OK

let euro = "\u{20ac}"
let txt = "Zeile 1\nZeile 2\nZeile 3"
let i = 1, x = 0.4
let s = "i=\(i), x=\(x)"  // i=1, x=0.4
let msg = "Die Wurzel von \(x) ist \(sqrt(x))"

let zk = "Eine Zeichenkette"
for c in zk.characters {
  print(c)
}

// String versus NSString
if true {
  func printString(_ s: String) {      // String-Parameter
    print(s)
  }
  func printNSString(_ s: NSString) {  // NSString-Parameter
    print(s)
  }
  
  let s = "abc"
  let ns = NSString(format: "%04d", 12)  // NSString-Instanz
  
  // printString(ns)
  // printNSString(s)

  printString(ns as String)
  printNSString(s as NSString)
 
  let path = "/Users/kofler"
  String(NSString(string: path).appendingPathComponent("Documents"))
  (path as NSString).appendingPathComponent("Documents") as String
}

// ä versus a"
if true {
  let single = "ä"           // ä als Einzelzeichen
  let cluster = "a\u{308}"   // ä als Zeichenkombination a + "
  cluster == single          // true!
}

// Länge von Zeichenketten
if true {
  let s = "abcäöüß€" + "a\u{308}"     // "abcäöüß€ä"
  s.characters.count                  //  9 Zeichen
  let start = s.startIndex
  let end = s.endIndex
  s.distance(from: start, to: end)    //  9 Zeichen
  s.unicodeScalars.count              // 10 Unicode-Skalare
  s.utf16.count                       // 10 UTF16-Zeichen
  s.utf8.count                        // 17 Byte in UTF8-Codierung
  
}

// Klein- und Großbuchstaben
if true {
  let s = "abcäöüß€" + "a\u{308}"
  s.uppercased()              // ABCÄÖÜSS€Ä
  s.lowercased()              // abcäöüß€ä
  s.capitalized               // Abcäöüß€Ä
  "abc efg".capitalized       // Abc Efg
}

// Leerzeichen / Whitespace eliminieren
if true {
  let s = " abc efg  "
  s.trimmingCharacters(in: .whitespaces)  // "abc efg"
}

// Zeichenketten umdrehen
if true {
  let s = "abcde"
  let r = String(s.characters.reversed())
}

// Zeichenketten filtern
if true {
  let isbn = "978-3-8362-2933-3"
  let cleanIsbn = String(isbn.characters.filter() {"0"..."9" ~= $0} )
  cleanIsbn
}



// Zeichenketten vergleichen und sortieren
if true {
  "abc" == "abc"            // true
  "Abc" == "abc"            // false
  "Abc" != "abc"            // true
  
  let lorem = "Lorem ipsum dolor sit amet"
  lorem.hasPrefix("Lorem")      // true
  lorem.hasPrefix("l")          // false
  lorem.hasSuffix("et")         // true
  lorem.hasSuffix("t amet")     // true

  
  "A" < "a"                 // true
  "Z" < "a"                 // true
  "a" < "b"                 // true
  "a" < "ä"                 // true
  "ä" < "b"                 // true
  "z" < "ß"                 // true
  
  // Array mit Zeichenketten sortieren
  var ar = ["A", "B", "C", "ä", "ö", "ü", "s", "t", "ß", "a", "z"]
  ar.sort(by: <)
  print(ar)
  // Ausgabe: [A, B, C, a, ä, ö, s, t, ü, z, ß]
  
  // sortieren in den aktuellen Ländereinstellungen, ohne Berücks. der Groß- und Kleinschreibung
  ar.sort() { $0.compare($1,
                        options: .caseInsensitive,
                        range: nil,
                        locale: nil) == .orderedAscending  }
  print(ar)
  // Ausgabe: [A, a, ä, B, C, ö, s, ß, t, ü, z]

  let sv = Locale(identifier: "sv_SV")
  ar.sort() { $0.compare($1,
                         options: .caseInsensitive,
                         range: nil,
                         locale: sv) == .orderedAscending  }
  print(ar)

  
  let haystack = "abc efg hij"
  let needle = "fg"
  if haystack.range(of: needle) != nil {
    print("gefunden")
  }

  let msg = "Lorem ipsum dolor sit amet"
  let rng = msg.range(of: "ipsum")  // Range-Objekt
  rng?.lowerBound                   // 6
  rng?.upperBound                   // 11
  msg.range(of: "xxx")              // nil
}

// Schleife über alle Vorkommen von 'find' in 'txt'
if true {
  var txt = "abc efg abc xxx abc"
  let find = "abc"
  let replace = "***"
  var start = txt.startIndex
  
  var rng = txt.range(of: find)
  while let rng = txt.range(of: find, range: start..<txt.endIndex) {
    txt.replaceSubrange(rng, with: replace)
    start = rng.lowerBound
  }
  print(txt)
}

// replace-Methode
if true {
  var txt = "abc efg abc xxx abc"
  let find = "abc"
  let replace = "***"
  txt = txt.replacingOccurrences(of: find, with: replace)
  print(txt)
}

// reguläre Muster (siehe auch die Datei regex.playground)
if true {
  let email = "kontakt@kofler.info"
  let ptn = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"
  let regex = try NSRegularExpression(pattern: ptn, options: [])
  let matches = regex.numberOfMatches(in: email,
                                      options: [],
                                      range: NSMakeRange(0, email.utf16.count))
  
  if matches == 1 {
    print("Die E-Mail-Adresse sieht korrekt aus.") 
  }
}

// Zeichenketten in Zeichen, Skalare und Bytes zerlegen
if true {
  let s = "abcäöüß€" + "a\u{308}"
  for c in s.characters {
    print(c)
  }
  let ar = Array(s.characters)
  
  for us in s.unicodeScalars {
    print("\(us) " + String(us.value, radix:16))
  }
  
  for i in s.utf8 {
    print(String(i, radix:16))
  }
  
  for i in s.utf16 {
    print(String(i, radix:16))
  }
}

// Zeichenkette aus Skalaren zusammensetzen
if true {
  Character(UnicodeScalar(97))  // "a"
  
  var s = ""  // s ist ein String
  s.append(Character(UnicodeScalar(97)))
  s.append(Character(UnicodeScalar(98)))
  s           // s enthält jetzt "ab"

}

// split und joined
if true {
  let txt1 = "Swift ist eine Programmiersprache."
  let words1 = txt1.components(separatedBy: " ")
  // words1 = ["Swift", "ist" ...]
  let txt2 = words1.joined(separator: " ")
  txt1 == txt2                     // true

  
  
  let words2 = txt1.characters.split() {$0 == " "}
                .map() { String($0) }
  words2
  // words2 = ["Swift", "ist" ...]
}

// Teilzeichenketten
if true {
  let s = "Lorem ipsum dolor sit amet"
  s[s.startIndex]                 // erstes Zeichen, "L"
  // s[s.endIndex]                // Fehler!
  s[s.index(before: s.endIndex)]
  s[s.startIndex..<s.endIndex]    // ganze Zeichenkette
  let fl = String(s.characters.first!) + String(s.characters.last!)
  
  s[s.index(after: s.index(after: s.startIndex))]
  s[s.index(before: s.index(before: s.endIndex))]
  
  s[s.index(s.startIndex, offsetBy: 2)]  // drittes Zeichen, "r"
  s[s.index(s.endIndex, offsetBy: -2)]   // vorletztes Zeichen, "e"
  
  let startpos = s.index(s.startIndex, offsetBy: 6)
  let endpos = s.index(startpos, offsetBy: 5)
  s[startpos..<endpos]
  
  let pos2 = s.endIndex                       // Ende von s
  let pos1 = s.index(pos2, offsetBy: -4)      // 4 Zeichen zurück
  s[pos1..<pos2]                              // "amet"

}
