

import UIKit

// liefert eine Zahl zwischen 0 und 50 oder nil
func perhapsANumber() -> Int? {
  let n = Int(arc4random_uniform(100))
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
      return
    }
  } else {
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
        var b = perhapsANumber() where a+b > 10
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
