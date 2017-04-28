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
  var lastupdate: Date!
  
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
    currencies = keys.sorted(by: <)
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
    let formatter = DateFormatter()
    formatter.dateFormat="yyyy-MM-dd H:mm"
    formatter.timeZone = TimeZone(abbreviation: "CET")
    lastupdate = formatter.date(from: "1900-01-01 12:00")!
    
    // Kurse von ECB laden
    let ecburl = URL(string:
      "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml")!
    let content:String
    do {
      // Info.plist enthält Ausnahmeregel für ecb-Webseite,
      // http://stackoverflow.com/questions/30720813
      content = try String(contentsOf: ecburl)
    } catch {
      print(">>> Fehler beim Lesen der Kurse")
      print(">>> \(error)")
      return false // aktuelle Kurse nicht verfügbar
    }

    // SWXMLHash-Objekt erzeugen
    let xml = SWXMLHash.parse(content)
    
    // Datum extrahieren
    let ecbtime = xml["gesmes:Envelope"]["Cube"]["Cube"].element?
      .attribute(by: "time")?.text ?? "1900-01-01"
    if ecbtime == "1900-01-01"  {
      // Datum nicht gefunden --> fehlerhafte Daten
      return false
    }
    lastupdate = formatter.date(from: ecbtime + " 15:00")
    
    // Schleife über alle Kurse
    for r in xml["gesmes:Envelope"]["Cube"]["Cube"]["Cube"] {
      if let currency = r.element?.attribute(by: "currency")?.text,
        let ratestr = r.element?.attribute(by: "rate")?.text
      {
        let rate = NSString(string: ratestr).doubleValue
        if rate != 0.0 {
          rates[currency] = rate  // dem Dictionary hinzufügen
        }
      }
    }
    return true  // alles bestens
  
  }
  
  // Kurse im Cache-Verzeichnis speichern
  private func saveRates() {
    if rates.count <= 1  {
      return  // nicht speichern, keine vollständigen Daten (zuletzt: 32 Kurse)
    }
    
    if let ratespath = getRatesFilename() {
      let dict = NSMutableDictionary()
      dict.setObject(lastupdate, forKey: "lastupdate" as NSCopying)
      dict.setObject(rates, forKey: "rates" as NSCopying)
      _ = dict.write(toFile: ratespath, atomically: true)
    }
    
  }
  
  // Kurse aus dem Cache-Verzeichnis lesen
  private func loadRates() {
    if let ratespath = getRatesFilename() {
      if let dict = NSMutableDictionary(contentsOfFile: ratespath) {
        if let lu = dict.object(forKey: "lastupdate") as? Date,
           let rt = dict.object(forKey: "rates") as? [String:Double]
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
    let formatter = DateFormatter()
    formatter.dateFormat="yyyy-MM-dd H:mm"
    lastupdate = formatter.date(from: "1900-01-01 12:00")!
  }

  // liefert Pfad zu 'rates.plist' in Cache-Verzeichnis
  private func getRatesFilename() -> String? {
    let fm = FileManager.default
    let urls = fm.urls(for: .cachesDirectory,
                       in: .userDomainMask)
    if let url = urls.first {
      let path = url.appendingPathComponent("rates.plist").path
      print(path)
      return path
      
    }
    return nil
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
  func convert(_ value:Double, from:String?, to:String?) -> Double {
    if from == nil || to==nil { return 0.0 }
    if let ratefrom = rates[from!], let rateto = rates[to!] {
      return value / ratefrom * rateto
    } else {
      return 0.0
    }
  }
  
  
  // macht aus "USD" --> "US" etc.
  static func getCountryFromCurrency(_ currency:String) -> String {
    if currency.characters.count <= 2 { return currency.lowercased() }
    let start = currency.startIndex
    let end = currency.characters.index(currency.startIndex, offsetBy: 1)
    return currency[start...end].lowercased()
  }
}
