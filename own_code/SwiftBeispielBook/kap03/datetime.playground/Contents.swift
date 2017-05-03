//: Playground - noun: a place where people can play

import UIKit

// Daten und Zeiten formattieren
if(true) {
  let now = NSDate()
  print(now)  // Ausgabe z.B. 2015-07-08 11:55:52 +0000
  
  let formatter = NSDateFormatter()
  formatter.dateFormat="d.M.yyyy H:mm"
  formatter.stringFromDate(now)  // z.B. "8.7.2015 13:56"
  
  formatter.locale = NSLocale(localeIdentifier: "de_DE")
  formatter.dateFormat="d. MMMM yyyy"
  formatter.stringFromDate(now)  // "8. Juli 2015"
  
  formatter.dateFormat = "yyyy-MM-dd"
  let sylvester2015 = formatter.dateFromString("2015-12-31")
}

// Zeitkomponenten extrahieren
if(true) {
  let now = NSDate()  // z. B. "Jul 14, 2015, 8:57 AM"
  let cal = NSCalendar.currentCalendar()
  // Tag, Monat und Jahr extrahieren
  // comps hat den Datentyp NSDateComponents
  let comps = cal.components([.Day, .Month, .Year], fromDate: now)
  // Zugriff auf die Einzelkomponenten
  comps.year    // 2015
  comps.month   // 7
  comps.day     // 14
}

// Rechnen mit Datum und Zeit
if(true) {
  let now = NSDate()                    // "8.7.2015 14:07"
  let cal = NSCalendar.currentCalendar()
  let twoHours = NSDateComponents()
  twoHours.hour=2
  let inTwoHours = cal.dateByAddingComponents(
    twoHours, toDate: now, options: [])
  let formatter = NSDateFormatter()
  formatter.dateFormat="H:mm"
  formatter.stringFromDate(inTwoHours!) // "16:07"
}