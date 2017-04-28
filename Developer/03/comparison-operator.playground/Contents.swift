//: Playground - noun: a place where people can play

import Cocoa


//: ## Neuer Vergleichsoperator für Zeichenketten


// neuen Vergleichsoperator definieren, ...
infix operator =~= : ComparisonPrecedence

// ... implementieren,
func =~= (left: String, right: String) -> Bool {
  return left.compare(right, options: .caseInsensitive) == .orderedSame
  
  // besser zu verstehen, aber langsamer
  // return left.uppercased() == right.uppercased()
}

// ... und ausprobieren
"abc" =~= "Abc"   // true
"äöü" =~= "ÄöÜ"   // true

//: ## Neuer Exponential-Operator

precedencegroup ExponentiationPrecedence {
  associativity: left
  higherThan: MultiplicationPrecedence
}
infix operator ** : ExponentiationPrecedence

func ** (base: Double, exponent: Double) -> Double {
  return pow(base, exponent)
}

1 + 2 ** 3  // 1 plus (2 hoch 3), Ergebnis 9
