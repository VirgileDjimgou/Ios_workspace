//: Playground - noun: a place where people can play

import Foundation

func palindromTest(s:String) -> Bool {
  let lower = s.lowercaseString
  let letters = NSCharacterSet.letterCharacterSet()
  let onlyLetters =
  lower.characters.filter(
    {String($0).rangeOfCharacterFromSet(letters) != nil})
  let reverseLetters = Array(onlyLetters).reverse()
  return String(onlyLetters) == String(reverseLetters)
}

palindromTest("abc")                                 // false
palindromTest("Otto")                                // true
palindromTest("Die Liebe fleht: Helfe bei Leid!")    // true
