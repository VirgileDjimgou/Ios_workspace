//
//  PopupViewController.swift
//  ios-popup
//
//  Created by Michael Kofler on 21.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

  @IBOutlet weak var infotxt: UITextView!
  
  override var preferredContentSize: CGSize {
    get {
      if infotxt != nil, let pvc = presentingViewController {
        return infotxt.sizeThatFits(pvc.view.bounds.size)
      }
      return super.preferredContentSize
    }
    set { super.preferredContentSize = newValue }
  }
}
