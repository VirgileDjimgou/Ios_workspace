//
//  main.swift
//  ip-address
//
//  Created by Michael Kofler on 19.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation


// Return IP address of WiFi interface (en0) as a String, or `nil`
func getIPAddresses() -> [String] {
  var addresses = [String]()
  
  // getifaddrs liefert Liste aller Netzwerkschnittstellen
  var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
  if getifaddrs(&ifaddr) == 0 {
    
    // Schleife über alle Schnittstellen
    var ptr = ifaddr
    while ptr != nil {
      // am Ende des Schleifenkörpers nächstes Element lesen
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
          if getnameinfo(&addr!,
                         socklen_t((addr?.sa_len)!),
                         &hostname,
                         socklen_t(hostname.count),
                         nil,
                         socklen_t(0),
                         NI_NUMERICHOST) == 0
          {
            if let address = String(validatingUTF8: hostname) {
              addresses.append(address)
            }
          }
        }
      }
    }
    // ifaddrs-Struktur wieder freigeben
    freeifaddrs(ifaddr)
  }
  
  return addresses
}

for  ipaddr in getIPAddresses() {
  print("Adresse: \(ipaddr)")
}
