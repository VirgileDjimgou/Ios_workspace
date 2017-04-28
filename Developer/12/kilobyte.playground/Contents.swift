//: Playground - noun: a place where people can play

import Cocoa


extension Int {
  var kB:Int    { return self * 1000 }
  var KiB:Int   { return self * 1024 }
  var MB:Int    { return self * 1000_000 }
  var MiB:Int   { return self * 1_048_576 }
  var GB:Int    { return self * 1000_000_000 }
  var GiB:Int   { return self * 1_073_741_824 }
  
  var tokB:Int  { return self / 1000 }
  var toKiB:Int { return self / 1024 }
  var toMB:Int  { return self / 1000_000 }
  var toMiB:Int { return self / 1_048_576 }
  var toGB:Int  { return self / 1000_000_000 }
  var toGiB:Int { return self / 1_073_741_824 }
}

let memory = 2.GiB    // 2.147.483.648
memory.toMiB          // 2.048
memory.tokB           // 2.147.483
