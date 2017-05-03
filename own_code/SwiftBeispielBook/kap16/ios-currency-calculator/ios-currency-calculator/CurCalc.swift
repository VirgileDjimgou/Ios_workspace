//
//  CurCalc.swift
//  ios-currency-calculator
//
//  Created by Michael Kofler on 06.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Foundation

// Klasse zur Durchführung von Währungsumrechnungen
class CurCalc {
  
  // Datum der Kurse
  var lastupdate: NSDate!
  
  // Dictionary für Kurs je Währung
  var rates: [String:Double]!
  
  // sortiertes Array mit allen Währungskürzeln
  var currencies: [String]!
  
  
  // init-Funktion
  init() {
    // aktuelle Kurse von ECB laden
    if getEcbRates() {
      saveRates()  // und in User Defaults speichern
    } else {
      loadRates()  // früher gespeicherte Kurse aus User Defaults laden
    }
    // sortierte Währungsliste erzeugen
    let keys = Array(rates.keys)
    currencies = keys.sort(<)
  }
  
  // Aufbau der ECB-Kursdatei
  //  <gesmes:Envelope ...>
  //    ...
  //    <Cube>
  //      <Cube time="2015-04-02">
  //        <Cube currency="USD" rate="1.0830"/>
  //        <Cube currency="JPY" rate="129.59"/>
  //        <Cube currency="BGN" rate="1.9558"/>
  //        <Cube currency="CZK" rate="27.570"/>
  //        ...
  private func getEcbRates() -> Bool {
    // Dictionary für Währungen, mit Defaulteintrag für Euro
    rates = ["EUR": 1.0]
    
    // Defaultdatum
    let formatter = NSDateFormatter()
    formatter.dateFormat="yyyy-MM-dd H:mm"
    formatter.timeZone = NSTimeZone(abbreviation: "CET")
    lastupdate = formatter.dateFromString("1900-01-01 12:00")!
    
    // Kurse von ECB laden
    do {
      // iOS 9: NSURL wünscht sich https mit TLSv1.2 SSL
      // www.ecb.europa.eu kann zwar https, aber hat kein ausreichend
      // modernes Zertifikat; daher brauchen wir eine Ausnahme in Info.plist,
      // damit wir die Seite klassisch via http lesen können
      // http://stackoverflow.com/questions/30720813/cfnetwork-sslhandshake-failed-ios-9-beta-1
      guard
        let ecburl = NSURL(string:
          "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml")
      else { return false }
      
      let content = try NSString(
        contentsOfURL:ecburl,
        encoding:NSUTF8StringEncoding) as String
      
      // SWXMLHash (siehe https://github.com/drmohundro/SWXMLHash, Code in Supporting Files)
      let xml = SWXMLHash.parse(content)
      
      
      // Datum extrahieren
      let ecbtime = xml["gesmes:Envelope"]["Cube"]["Cube"].element?
        .attributes["time"] ?? "1900-01-01"
      if ecbtime == "1900-01-01" || lastupdate == nil {
        // Datum nicht gefunden --> fehlerhafte Daten
        return false
      }
      lastupdate = formatter.dateFromString(ecbtime + " 15:00")
      
      // Schleife über alle Kurse
      for r in xml["gesmes:Envelope"]["Cube"]["Cube"]["Cube"] {
        if let currency = r.element?.attributes["currency"],
          ratestr = r.element?.attributes["rate"]
        {
          let rate = NSString(string: ratestr).doubleValue
          if rate != 0.0 {
            rates[currency] = rate  // dem Dictionary hinzufügen
          }
        }
      }
      return true  // alles bestens
    } catch _ {
      return false // aktuelle Kurse nicht verfügbar
    }
  }
  
  // Kurse im Cache-Verzeichnis speichern
  private func saveRates() {
    if rates.count <= 1  {
      return  // nicht speichern, keine vollständigen Daten (zuletzt: 32 Kurse)
    }

    if let ratespath = getRatesFilename() {
      let dict = NSMutableDictionary()
      dict.setObject(lastupdate, forKey: "lastupdate")
      dict.setObject(rates, forKey: "rates")
      dict.writeToFile(ratespath, atomically: true)
    }

  }
  
  // Kurse aus dem Cache-Verzeichnis lesen
  private func loadRates() {
    if let ratespath = getRatesFilename() {
      if let dict = NSMutableDictionary(contentsOfFile: ratespath) {
        if let lu = dict.objectForKey("lastupdate") as? NSDate,
           let rt = dict.objectForKey("rates") as? [String:Double]
        {
          lastupdate = lu
          rates = rt
          return
        }
      }
    }
    // keine gültigen Daten gefunden, 
    // warum auch immer: Defaults verwenden
    rates = ["EUR": 1.0]
    let formatter = NSDateFormatter()
    formatter.dateFormat="yyyy-MM-dd H:mm"
    lastupdate = formatter.dateFromString("1900-01-01 12:00")!
  }

  // liefert Pfad zu 'rates.plist' in Cache-Verzeichnis
  private func getRatesFilename() -> String? {
    let pfd = NSSearchPathForDirectoriesInDomains(
      .CachesDirectory, .UserDomainMask, true)
    if let path:NSString = pfd.first {
      return path.stringByAppendingPathComponent("rates.plist")
    } else {
      return nil
    }
  }
  
  /// This function converts a value from on currency to another one.
  ///
  /// Usage: convert("USD", "EUR", 1.23)
  ///
  /// **Warning:** Only works for currencies defined in `rates`!
  ///
  /// - parameter value: The value to convert.
  /// - parameter from:  The currency of `value`.
  /// - parameter to:    The currency of the result.
  ///
  /// - returns: The converted value or 0.0, if `from` or `to` are invalid.
  func convert(value:Double, from:String?, to:String?) -> Double {
    if from == nil || to==nil { return 0.0 }
    if let ratefrom = rates[from!], rateto = rates[to!] {
      return value / ratefrom * rateto
    } else {
      return 0.0
    }
  }
  
  
  // macht aus "USD" --> "US" etc.
  static func getCountryFromCurrency(currency:String) -> String {
    if currency.characters.count <= 2 { return currency.lowercaseString }
    let start = currency.startIndex
    let end = currency.startIndex.advancedBy(2)
    return currency[start..<end].lowercaseString
  }
}