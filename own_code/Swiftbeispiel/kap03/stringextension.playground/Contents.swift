

import Foundation

//: ### String-Extension, die einen einfacheren Zugriff auf einzelne Zeichen bzw. Teilzeichenketten gibt

extension String {
  // liefert die Länge der Zeichenkette
  var len:Int {
    return self.characters.count
  }
  
  // liefert Zeichen an der Position n als String
  subscript(n:Int) -> String {
    if n<0 || n>=self.len {
      return "";
    } else {
      return String(self[self.startIndex.advancedBy(n)])
    }
  }
  
  // liefert Substring von n1 bis n2
  subscript(start:Int, end:Int) -> String {
    var n1 = start, n2=end;
    
    if n1<0        { n1=0; }         // auf gültigen
    if n1>self.len { n1=self.len; }  // Wertebereich
    if n2<0        { n2=0; }         // achten
    if n2>self.len { n2=self.len; }
    
    if n2<n1   {                // Anfang nach Ende:
      return "";                // leere Zeichenkette
    } else {                    // OK
      return self[
        self.startIndex.advancedBy(n1) ..< self.startIndex.advancedBy(n2) ]
    }
  }
  
  // liefert Substring für Integer-Bereich
  subscript(rng:Range<Int>) -> String {
    return self[rng.startIndex, rng.endIndex];
  }
}

//: ### Anwendungsbeispiele


let s = "abcde"
s.len               // 5
s[0]                // "a"
s[4]                // "e"
s[0..<5]            // "abcde"
s[0, 5]             // "abcde", gleichwertig
s[2..<4]            // "cd"
