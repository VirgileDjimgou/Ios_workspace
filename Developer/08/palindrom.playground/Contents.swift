//: Playground - noun: a place where people can play

import Foundation

func palindromTest(_ s:String) -> Bool {
  let lower = s.lowercased()
  let onlyLetters =
    lower.characters.filter()
      { String($0).rangeOfCharacter(from: .letters) != nil }
  return String(onlyLetters) == String(onlyLetters.reversed())
}

palindromTest("abc")                                 // false
palindromTest("Otto")                                // true
palindromTest("Die Liebe fleht: Helfe bei Leid!")    // true
