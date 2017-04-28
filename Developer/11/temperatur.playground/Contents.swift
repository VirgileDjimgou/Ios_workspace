import Foundation

struct Temperature {
  var kelvin:Double  // interne Speicherung in Kelvin

  // init-Funktionen für Kelvin und Celsius
  init(kelvin: Double) {
    self.kelvin = kelvin
  }
  init(celsius: Double) {
    self.kelvin = celsius + 273.15
  }
  init(fahrenheit: Double) {
    self.kelvin = (fahrenheit - 32.0) / 1.8 + 273.15
  }
  
  // Computed Properties für Celsius und Fahrenheit
  var celsius: Double {
    get { return kelvin - 273.15 }
    set { kelvin = newValue + 273.15 }
  }
  
  var fahrenheit: Double {
    get { return celsius * 1.8 + 32.0 }
    set { kelvin = (newValue - 32.0) / 1.8 + 273.15 }
  }
}


var t = Temperature(celsius: 100)
t.celsius
t.fahrenheit
t.kelvin

