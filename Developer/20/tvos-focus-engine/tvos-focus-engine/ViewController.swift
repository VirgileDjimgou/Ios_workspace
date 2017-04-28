//
//  ViewController.swift
//  tvos-focus-engine
//
//  Created by Michael Kofler on 26.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var currentlySelected: MyView? = nil
  
  @IBOutlet weak var msgLabel: UILabel!
  @IBOutlet weak var startMv: MyView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.updateFocusIfNeeded()
    self.setNeedsFocusUpdate()
  }

  override var preferredFocusEnvironments: [UIFocusEnvironment] {
    return [startMv]
  }
  
  
  // die Fokus-Engine hat einem neuen Steuerelement
  // den Fokus gegeben
  override func didUpdateFocus(
    in context: UIFocusUpdateContext,
    with coordinator: UIFocusAnimationCoordinator)
  {
    // dieses Steuerelement ist nicht mehr fokussiert
    if let prev = context.previouslyFocusedItem as? MyView {
      prev.alpha = 0.5
    }

    // dafür ist nun dieses Steuerelement ausgewählt
    if let next = context.nextFocusedItem as? MyView {
      next.alpha = 1
      currentlySelected = next
    } else {
      currentlySelected = nil
    }
  }
  
  // ein Button wurde angeklickt
  @IBAction func buttonClicked(_ sender: UIButton) {
    msgLabel.text =
      "Der Button \(sender.title(for: .normal)!) wurde angeklickt."
  }

  // eine Taste der Fernbedienung wurde gedrückt
  override func pressesBegan(_ presses: Set<UIPress>,
                             with event: UIPressesEvent?)
  {
    for p in presses {
      if p.type == .select, let mv = currentlySelected  {
        msgLabel.text =
          "Das Rechteck \(mv.name) wurde angeklickt."
      }
    }
  }
  
  
}

