//: Playground - noun: a place where people can play

import UIKit

let now = Date()
print(now)

// Datum und Zeit formatieren
let formatter = DateFormatter()
formatter.dateFormat = "d.M.yyyy H:mm"
formatter.string(from: now)

formatter.locale = Locale(identifier: "de_DE")
formatter.dateFormat = "d. MMMM yyyy"
formatter.string(from: now)

formatter.dateFormat = "hh:mm"
formatter.string(from: now)

// Datum und Zeit parsen
formatter.dateFormat = "yyyy-MM-dd"
let sylvester2016 = formatter.date(from: "2016-12-31")

// Zeitkomponenten extrahieren
let cal = Calendar.current

// Tag, Monat und Jahr extrahieren
// comps hat den Datentyp DateComponents
let comps = cal.dateComponents([.day, .month, .year], from: now)
let y = comps.year    // Int?
let m = comps.month   // Int?
let d = comps.day     // Int?

// Rechnen mit Datum und Uhrzeit
// Uhrzeit in zwei Stunden
let inTwoHours = now + 3600 * 2

// Datum in zwei Monaten
// let now = Date()
// let formatter = DateFormatter()
// let cal = Calender.current
var twoMonths = DateComponents()
twoMonths.month = 2
if let inTwoMonths = cal.date(byAdding: twoMonths, to: now) {
  formatter.dateFormat = "d. M. yyyy"
  formatter.string(from: inTwoMonths)
}

let inFiveSeconds = now + 5
inFiveSeconds > now

