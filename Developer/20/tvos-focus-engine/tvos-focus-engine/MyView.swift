//
//  MyView.swift
//  tvos-focus-engine
//
//  Created by Michael Kofler on 26.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

@IBDesignable
class MyView : UIView {
  
  // Eigenschaft zur Benennung/Identifizierung des Steuerelements
  @IBInspectable
  var name: String = ""
  
  // das Steuerelement ist fokussierbar
  override var canBecomeFocused: Bool {
    return true
  }
}
