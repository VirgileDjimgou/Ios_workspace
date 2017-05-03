//: Playground - noun: a place where people can play

import UIKit

// Einführung
if(true) {
  let s = "Eine Zeichenkette"
  for c in s.characters {
    print(c)
  }
  
  func myPrint(s:String) { print(s) }    // String-Parameter
  let ns = NSString(format: "%04d", 12)  // NSString-Instanz
  // myprint(ns)                            // Fehler!
  myPrint(ns as String)                  // so funktioniert es
}

// Syntax
if(true) {
  let s1 = "abc"
  let s2 = ""
  var s3 = s1 + s2 + "xxx"  // "abcxxx"
  s3+="yz"                  // "abcxxxyz"
  s2.isEmpty                // true
  s3.isEmpty                // false

  String()                                        // ""
  String(127, radix:16)                           // "7f"
  String(count:5, repeatedValue:Character("*"))   // "*****"
  String(format:"%.2f", sqrt(2.0))                // "1.41"

  // let longMsg = "Zeile 1
  // Zeile 2"                  // Fehler
  let longMsg = "Zeile 1\n" +
  "Zeile 2"               // OK

  let euro = "\u{20ac}"
  let txt = "Zeile 1\nZeile 2\nZeile 3"
  let i=1, x=0.4
  let s="i=\(i), x=\(x)"  // i=1, x=0.4
  let msg="Die Wurzel von \(x) ist \(sqrt(x))"
}

// Länge von Zeichenketten
if(true) {
  let s = "abcäöüß€" + "a\u{308}"
  s.characters.count                 //  9 Zeichen
  s.startIndex.distanceTo(s.endIndex) //  9 Zeichen
  s.unicodeScalars.count             // 10 Unicode-Skalare
  s.utf16.count                      // 10 UTF16-Zeichen
  s.utf8.count                       // 17 Byte in UTF8-Codierung
}

// Vergleichen und Sortieren
if(true) {
  "abc" == "abc"            // true
  "Abc" == "abc"            // false
  "Abc" != "abc"            // true
  
  "A" < "a"                 // true
  "Z" < "a"                 // true
  "a" < "b"                 // true
  "a" < "ä"                 // true
  "ä" < "b"                 // true
  "z" < "ß"                 // true
  // Array mit Zeichenketten sortieren
  var ar = ["A", "B", "C", "ä", "ö", "ü", "s", "t", "ß", "a", "z"]
  ar.sortInPlace(<)
  print(ar)
  // Ausgabe: [A, B, C, a, ä, ö, s, t, ü, z, ß]
  
  ar.sortInPlace( { $0.localizedCaseInsensitiveCompare($1) ==
    NSComparisonResult.OrderedAscending } )
  print(ar)
  // Ausgabe: [A, a, ä, B, C, ö, s, ß, t, ü, z]

  let sv = NSLocale(localeIdentifier: "sv_SV")
  ar.sortInPlace( { $0.compare($1, locale:sv) ==
    NSComparisonResult.OrderedAscending } )
  print(ar)
  // Ausgabe: [a, A, B, C, s, ß, t, ü, z, ä, ö]
  
  let lorem = "Lorem ipsum dolor sit amet"
  lorem.hasPrefix("Lorem")      // true
  lorem.hasPrefix("l")          // false
  lorem.hasSuffix("et")         // true
  lorem.hasSuffix("t amet")     // true
}

// Suchen + Ersetzen
if(true) {
  var haystack = "abc efg hij"
  var needle = "fg"
  if haystack.rangeOfString(needle) != nil {
    print("gefunden")
  }

  haystack = "Lorem ipsum dolor sit amet"
  haystack.rangeOfString("ipsum")    // 6..<11
  haystack.rangeOfString("xxx")      // nil

  haystack = "abc efg abc xxx abc"
  needle = "abc"
  var rng = haystack.rangeOfString(needle)
  while rng != nil {
    print(rng!)  // Ausgabe: 0..<3, 8..<11, 16..<19
    rng = haystack.rangeOfString(
      needle, range:rng!.endIndex..<haystack.endIndex)
  }

  let s1 = "abc efg abc xxx abc"
  let s2 = s1.stringByReplacingOccurrencesOfString("abc", withString: "ABC")
  // s2 = "ABC efg ABC xxx ABC"
}

// reguläre Ausdrücke
if(true) {
  let email = "kontakt@kofler.info"
  let pattern = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"
  
  let regex = try NSRegularExpression(pattern:pattern, options:[])
  let matches = regex.numberOfMatchesInString(email,
    options: [],
    range: NSMakeRange(0, email.utf16.count))
  
  if matches == 1 {
    print("Die E-Mail-Adresse sieht korrekt aus.")
  }
}

// Bestandteile
if(true) {
  let s = "abcäöüß€" + "a\u{308}"
  for c in s.characters {
    print(c)
  }
  // Ausgabe: a b c ä ö ü ß € ä
  
  var ar = Array(s.characters)
  
  for us in s.unicodeScalars {
    print("\(us) " + String(us.value, radix:16))
  }
  // Ausgabe
  // a 61
  // b 62
  // c 63
  // ä e4
  // ö f6
  // ü fc
  // ß df
  // € 20ac
  // a 61
  // " 308
  
  for i in s.utf8 {
    print(String(i, radix:16))
  }
  // Ausgabe: 61 62 63 c3 a4 c3 b6 c3 bc c3 9f e2 82 ac 61 cc 88
  
  for i in s.utf16 {
    print(String(i, radix:16))
  }
  // Ausgabe: 61 62 63 e4 f6 fc df 20ac 61 308
 
  
  Character(UnicodeScalar(97))  // "a"

  var x = ""  // x ist ein String
  x.append(Character(UnicodeScalar(97)))
  x.append(Character(UnicodeScalar(98)))
  x           // x enthält jetzt "ab"
}

// split und join
if(true) {
  let txt1 = "Swift ist eine Programmiersprache."
  let words = txt1.characters.split() {$0 == " "}.map { String($0) }
  // words = ["Swift", "ist" ...]
  let txt2 = words.joinWithSeparator(" ")
  txt1 == txt2                     // true

  let words2 = txt1.componentsSeparatedByString(" ")
  // words2 = ["Swift", "ist" ...]
}

// manipulieren
if(true) {
  var s = "abcäöüß€" + "a\u{308}"
  s.uppercaseString                 // ABCÄÖÜSS€Ä
  s.lowercaseString                 // abcäöüß€ä
  s.capitalizedString               // Abcäöüß€Ä
  "abc efg".capitalizedString       // Abc Efg

  s = " abc efg  "
  s.stringByTrimmingCharactersInSet(
    NSCharacterSet.whitespaceCharacterSet())  // "abc efg"
  
  s = "abcde"
  let r = String(Array(s.characters).reverse())

  let isbn = "978-3-8362-2933-3"
  let cleanIsbn = String(isbn.characters.filter({"0"..."9" ~= $0}))
  //  cleanIsbn = "9783836229333"
}

// Teilzeichenketten
if(true) {
  let s = "Lorem ipsum dolor sit amet"
  s[s.startIndex]                 // erstes Zeichen, "L"
  // s[s.endIndex]                // Fehler!
  s[s.endIndex.predecessor()]     // letztes Zeichen, "t"
  s[s.startIndex..<s.endIndex]    // ganze Zeichenkette

  s.characters.first              // erstes Zeichen, "L"
  s.characters.last               // letztes Zeichen, "t"

  // s[2]                                   // Fehler!
  s[s.startIndex.successor().successor()]   // 3. Zeichen, "r"
  s[s.endIndex.predecessor().predecessor()] // vorletztes Z., "e"
  
  let startpos = s.startIndex.advancedBy(6)   // 6 Z. überspringen
  let endpos = startpos.advancedBy(5)         // 5 Zeichen lesen
  s[startpos..<endpos]                      // "ipsum"
  
  let pos2 = s.endIndex                     // Ende von s
  let pos1 = pos2.advancedBy(-4)            // 4 Zeichen zurück
  s[pos1..<pos2]                            // "amet"
}

// formatieren
if(true) {
  let x = 2.0
  let sq = sqrt(x)
  let s1 = "Die Wurzel von \(x) beträgt \(sq)."
  // s1 = "Die Wurzel von 2.0 beträgt 1.4142135623731."

  let fmt = "Die Wurzel von %.3f beträgt %.3f."
  let s2 = String(format:fmt, x, sq)
  // s2 = "Die Wurzel von 2.000 beträgt 1.414."
  
  let de = NSLocale(localeIdentifier: "de_DE")
  let s4 = String(format:fmt, locale:de,  x, sq)
  // s4 = "Die Wurzel von 2,000 beträgt 1,414."

}


// formatieren wie in Python
func % (format:String, args:[CVarArgType]) -> String {
  return String(format: format,  arguments:args)
}

if(true) {
  let fmt = "Die Wurzel von %.3f beträgt %.3f."
  let x = 2.0
  let sq = sqrt(x)
  let s3 = fmt % [x, sq]
  // s3 = "Die Wurzel von 2.000 beträgt 1.414."
}

// NumberFormatter
if(true) {
  let fmt = NSNumberFormatter()
  // fmt.locale = NSLocale(localeIdentifier: "de_DE")
  fmt.usesGroupingSeparator=true
  fmt.stringFromNumber(1234567)     // 1.234.567
  fmt.minimumFractionDigits=2
  fmt.maximumFractionDigits=2
  fmt.stringFromNumber(1234.567)    // 1.234,57
  fmt.stringFromNumber(1234)        // 1.234,00
}

// parsen
if(true) {
  Int("123")      // 123
  Int("123abc")   // nil
  Int("12e3")     // nil
  Int("123 ")     // nil
  Int(" 123")     // nil

  let s = "123"
  let n = Int(s) ?? 0  // Datentyp Int
  let m = Int(s)       //          Int?
  let o = m! + 3       //          Int

  "123".integerValue          // 123
  "123abc".integerValue       // 123
  "12e3".integerValue         // 12
  "123 ".integerValue         // 123
  " 123".integerValue         // 123
  "x".integerValue            // 0
  
  // s.integerValue                // Fehler
  NSString(string:s).integerValue  // 123

  Double("123.5")                  //  132,5 (Datentyp Double?)
  Double("123,5")                  //    nil
  Double("abc")                    //    nil
  "123.5".doubleValue              //  123,5
  " 123.5".doubleValue             //  123,5
  " 123.5xx".doubleValue           //  123,5
  "12+13".doubleValue              //   12,0
  "1e3".doubleValue                // 1000,0
  "12,34".doubleValue              //   12,0
  "x".doubleValue                  //    0,0
}

// parsen mit dem NSNumberFormatter
if(true) {
  let fmt = NSNumberFormatter()
  fmt.numberStyle = NSNumberFormatterStyle.DecimalStyle
  fmt.locale = NSLocale(localeIdentifier: "de_DE")
  fmt.numberFromString("1.234.567,89")    // 1234567,89 / NSNumber?
  fmt.numberFromString("abc")             // nil        / NSNumber?
  let x = fmt.numberFromString("3,14159") // 3,14159    / NSNumber?
  let y = Double(x!) + 1.2                // 4,34159    / Double

}
