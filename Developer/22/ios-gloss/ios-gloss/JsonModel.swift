// Typen für JSON-Datei



struct Top : Decodable {
  let menu: Menu?
  
  init?(json: JSON) {
    self.menu = "menu" <~~ json
  }
}

struct Menu : Decodable {
  let id: String?
  let value: String?
  let popup: Popup?
  
  init?(json: JSON) {
    self.id = "id" <~~ json
    self.value = "value" <~~ json
    self.popup = "popup" <~~ json
  }
}

struct Popup : Decodable {
  let menuitem: [Menuitem]?
  
  init?(json:JSON) {
    self.menuitem = "menuitem" <~~ json
  }
}

struct Menuitem : Decodable {
  let value: String?
  let onclick: String?
  
  init?(json: JSON) {
    self.value = "value" <~~ json
    self.onclick = "onclick" <~~ json
  }
}
