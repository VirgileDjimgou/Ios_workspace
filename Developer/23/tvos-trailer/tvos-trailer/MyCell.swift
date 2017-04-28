//
//  MyCell.swift
//  tvos-trailer
//
//  Created by Michael Kofler on 29.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class MyCell : UICollectionViewCell {
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var img: UIImageView!
  @IBOutlet weak var descr: UITextView!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  override var canBecomeFocused: Bool {
    return true
  }
  
  func markSelected(state: Bool) {
    if state == true {
      self.backgroundColor = selectedColor
    } else {
      self.backgroundColor = unselectedColor
    }
  }
}
