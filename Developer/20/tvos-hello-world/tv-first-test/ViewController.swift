//
//  ViewController.swift
//  tv-first-test
//
//  Created by Michael Kofler on 29.04.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var outputText: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  
  @IBAction func showDateTime(_ sender: UIButton) {
    let now = Date()
    outputText.text = now.description(with: Locale.current)
  }

  @IBAction func showMemory(_ sender: UIButton) {
    let gbyte = Double(1024*1024*1024)
    let ram = ProcessInfo.processInfo.physicalMemory
    let flashtotal = deviceTotalInBytes()
    let flashfree = deviceRemainingFreeSpaceInBytes()
    
    // formatieren
    let fmt = NumberFormatter()
    fmt.minimumFractionDigits = 2
    fmt.maximumFractionDigits = 2
   
    let ramfmt   =
      fmt.string(from: NSNumber(value: Double(ram) / gbyte))!
    let flashfreefmt =
      fmt.string(from: NSNumber(value: Double(flashfree) / gbyte))!
    let flashtotalfmt =
      fmt.string(from: NSNumber(value: Double(flashtotal) / gbyte))!
    
    // ausgeben
    outputText.text =
      "Arbeitsspeicher (RAM, insgesamt):  \(ram) Byte = \(ramfmt) GiB\n" +
      "Gerätespeicher (Flash, insgesamt): \(flashtotalfmt) GiB\n" +
      "Gerätespeicher (Flash, noch frei): \(flashfreefmt) GiB"
  }
  
  @IBAction func showVersion(_ sender: UIButton) {
    let v = UIDevice.current.systemVersion
    outputText.text = "tvOS-Version \(v)"
  }
  
  @IBAction func showIpAddress(_ sender: UIButton) {
    var out = ""
    for s in getIPAddresses() {
      out += s + "\n"
    }
    outputText.text = "IP-Adresse(n): " + out
  }
  
  // Hilfsfunktionen
  
  // liefert Größe des Dateisystems, in dem sich das
  // Home-Verzeichnis befindet
  // Quelle: http://stackoverflow.com/questions/26198073
  func deviceTotalInBytes() -> Int64 {
    do {
      let systemAttributes =
        try FileManager.default.attributesOfFileSystem(
              forPath: NSHomeDirectory() as String)
      let space = (systemAttributes[.systemSize]
                  as? NSNumber)?.int64Value
      return space!
    } catch {
      return 0
    }
    
  }

  // liefert freien Speicherplatz des Dateisystems, in dem
  // sich das Home-Verzeichnis befindet
  func deviceRemainingFreeSpaceInBytes() -> Int64 {
    do {
    let systemAttributes =
      try FileManager.default.attributesOfFileSystem(
            forPath: NSHomeDirectory() as String)
      let freeSize = (systemAttributes[.systemFreeSize]
          as? NSNumber)?.int64Value
      return freeSize!
    } catch {
      return 0
    }
  }
  

  
  // Quelle: http://stackoverflow.com/questions/25626117
 
  // erfordert eine weitere Objective-C-Datei mit der Zeile
  // #import <Foundation/Foundation.h>
  // sowie den von Xcode erzeugten Bridging Header, siehe:
  // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html
  
  // tvOS hat anscheinend immer nur eine IP-Adresse, auch wenn WLAN und Ethernet gleichzeitig verfügbar sind.
  // In diesem Fall wird Ethernet der Vorzug gegeben.
  
  // Return IP address of WiFi interface (en0) as a String, or `nil`
  func getIPAddresses() -> [String] {
    var addresses = [String]()
    
    // getifaddrs liefert Liste aller Netzwerkschnittstellen
    var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
      
      // Schleife über alle Schnittstellen
      var ptr = ifaddr
      while ptr != nil {
        defer { ptr = ptr?.pointee.ifa_next }
        
        let flags = Int32((ptr?.pointee.ifa_flags)!)
        var addr = ptr?.pointee.ifa_addr.pointee
        
        // nur aktive Schnittstellen, Loopback ignorieren
        if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) ==
           (IFF_UP|IFF_RUNNING)
        {
          // IPv4 und IPv6
          if addr?.sa_family == UInt8(AF_INET) ||
             addr?.sa_family == UInt8(AF_INET6) {
            
            // in lesbare Form umwandeln
            var hostname = [CChar](repeating: 0,
                                   count: Int(NI_MAXHOST))
            if (getnameinfo(&addr!, socklen_t((addr?.sa_len)!),
                            &hostname,
                            socklen_t(hostname.count),
                            nil,
                            socklen_t(0),
                            NI_NUMERICHOST) == 0)
            {
              if let address = String(validatingUTF8: hostname) {
                addresses.append(address)
              }
            }
          }
        }
      }
      freeifaddrs(ifaddr)
    }
    
    return addresses
  }
}

