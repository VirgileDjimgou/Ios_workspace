//: Playground - noun: a place where people can play

import UIKit

extension String {
  // liefert die Länge der Zeichenkette
  var len: Int {
    return self.characters.count
  }
  
  // liefert Substring von n1 bis n2
  subscript(start:Int, end:Int) -> String {
    var n1 = start, n2=end
    if n1<0        { n1 = 0 }         // auf gültigen
    if n1>self.len { n1 = self.len }  // Wertebereich
    if n2<0        { n2 = 0 }         // achten
    if n2>self.len { n2 = self.len }
    
    if n2 < n1   {              // Anfang nach Ende:
      return ""                 // leere Zeichenkette
    } else  {                   // OK
      let pos1 = self.index(self.startIndex, offsetBy: n1)
      let pos2 = self.index(self.startIndex, offsetBy: n2)
      return self[pos1..<pos2]
    }
  }
  
  // liefert das Zeichen an der Position n als String
  // (self[a, b] ruft den obigen subscript-Code auf)
  subscript(n: Int) -> String {
    return self[n, n+1]
  }

  // liefert Substring für Integer-Bereich
  subscript(rng: Range<Int>) -> String {
    return self[rng.lowerBound, rng.upperBound]
  }
}


let s = "abcde"
s.len               // 5
s[0]                // "a"
s[4]                // "e"
s[0..<5]            // "abcde"
s[0, 5]             // "abcde", gleichwertig
s[2..<4]            // "cd"

// Grenzfälle
s[-1]               // ""
s[5]                // ""
s[2..<10]           // "cde"
s[-3..<3]           // "abc"

