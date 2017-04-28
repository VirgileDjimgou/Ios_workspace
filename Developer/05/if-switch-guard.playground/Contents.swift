//: Playground - noun: a place where people can play

import Cocoa

// normales if
if true {
  let n = Int(arc4random_uniform(100))  // Zahl zwischen 0 und 99
  if n<10 {
    print("n ist kleiner 10")
  } else if n<=50 {
    print("n liegt zwischen 10 und 50")
  } else if n<75 && n%2==0 {
    print("n ist eine gerade Zahl zwischen 52 und 74")
  } else {
    print("n ist eine andere Zahl: \(n)")
  }
}

// if-let
if true {
  let opt = Int("123")  // Datentyp 'Int?'
  if let  x = opt {
    // dieser Code wird nur ausgeführt, wenn das
    // Optional nicht nil ist; x ist eine Konstante
    // und hat den Datentyp Int
    print(x)
  }
  
  if var x = opt {
    // dieser Code wird nur ausgeführt, wenn das
    // Optional nicht nil ist; x ist eine Variable
    // und hat den Datentyp Int
    x += 1
    print(x)
  }
  
  
  
  // Int-Beispiel
  let someStringData = "10"
  if let n = Int(someStringData)  {
    // Int war erfolgreich, n ist eine Int-Zahl
    for var i in n...12 {
      print(i)
    }
  }  // hier endet der Geltungsbereich von n

  
  
  // URL-Beispiel
  let fm = FileManager.default
  let urls = fm.urls(for: .documentDirectory,
                     in: .userDomainMask)
  if let url = urls.first {
    print(url.path)
  }

  
  var opt1: Int? = 4   // lauter Optionals mit
  var opt2: Int? = 2   // dem Datentyp 'Int?'
  var opt3: Int? = 3
  if let a=opt1,
     a == 4,
     let b=opt2,
     let c=opt3,
     a==b*b && c>2
  {
    print("bingo")
  }

  
}

// guard
if true {
  // liefert eine Zahl zwischen 0 und 50 oder nil
  func perhapsANumber() -> Int? {
    let n = Int(arc4random_uniform(100)) // Zufallszahl (0 bis 99)
    if n <= 50 {
      return n
    } else {
      return nil
    }
  }
  
  // ohne guard
  func f() {
    if let a = perhapsANumber() {
      let n = 2 * a
      if let b = perhapsANumber() {
        print(n + b)
        // noch mehr Code, Teil 1
      } else {
        // zweite Bedingung nicht erfüllt, Abbruch
        return
      }
    } else {
      // erste Bedingung nicht erfüllt, Abbruch
      return
    }
    // noch mehr Code, Teil 2
  }
  
  // mit guard
  func g() {
    guard let a = perhapsANumber() else { return }
    let n = 2 * a
    guard let b = perhapsANumber() else { return }
    print(n + b)
    // noch mehr Code, Teil 1
    // noch mehr Code, Teil 2
  }
  
  // guard funktioniert auch mit var und where
  func h() {
    guard let a = perhapsANumber(),
          var b = perhapsANumber(),
          a+b > 10
      else {
        return
    }
    b = b + 1
    let n = 2 * a
    print(n + b)
    // noch mehr Code, Teil 1
    // noch mehr Code, Teil 2
  }
  
  
  f()
  g()
}

// switch
if true {
  let monat = "Oktober", jahr = 2016
  var tage: Int?
  switch monat {
  case "Januar", "März", "Mai", "Juli", "August",
       "Oktober", "Dezember":
    tage = 31
    
  case "April", "Juni", "September", "November":
    tage = 30
    
  case "Februar":
    if jahr % 4 == 0 &&
      (jahr % 100 != 0 || jahr % 400 == 0)
    {
      tage = 29
    } else {
      tage = 28
    }
    
  default:
    print("Ungültiger Monatsname!")
  }

  if tage != nil {
    print("\(tage!) Tage")
  }
  
  // switch mit Range-Operator
  let d = 1.5
  switch d {
  case 0.0...1.0:
    print("0 <= d <= 1")
    
  case 1.0...2.0:
    print("1 < d <= 2")
    
  default:
    print("anderer Wert")
  }
  
  // switch mit Tupel und where
  let pt = (0.5, 1.0)
  switch pt {
  case (0, 0):
    print("Koordinatenursprung")
    
  case (_, 0):
    print("Auf der X-Achse")
    
  case (0, _):
    print("Auf der Y-Achse")
    
  case let (x, y) where x>0 && y>0:
    print("Im ersten Quadranten")
    
  default:
    print("Sonstwo")
  }
  
  
  // switch mit where
  let s = "bild.jpg"
  switch s {
  case let jpg  where jpg.lowercased().hasSuffix(".jpg"):
    print("JPEG-Datei")
    
  case let gif  where gif.hasSuffix(".gif"):
    print("GIF-Datei")
    
  default:
    print("eine andere Datei")
  }


}





// Versions- und plattformabhängiger Code
if #available(iOS 9.2, macOS 10.11, *) {
  // ausführen, wenn zumindest iOS 9.2 oder macOS 10.11
  // zur Verfügung steht
  print("iOS>=9.2 oder macOS >= 10.11")
} else {
  // bei älteren Versionen ausführen
  print("zu alt")
}

#if os(tvOS)
  print("läuft unter tvOS")
#else
  print("anderes OS")
#endif

#if arch(x86_64)
  print("x86-Platform mit 64-Bit-CPU")
#endif

#if swift(>=3.0)
  print("Die Swift-Version ist 3.0 oder größer.")
#endif
