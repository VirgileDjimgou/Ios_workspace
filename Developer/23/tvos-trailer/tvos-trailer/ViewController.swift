//
//  ViewController.swift
//  tvos-trailer
//
//  Created by Michael Kofler on 29.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

  @IBOutlet weak var filmcoll: UICollectionView!
  
  var films = [Film]()
  
  // Initialisierung
  override func viewDidLoad() {
    super.viewDidLoad()
    filmcoll.dataSource = self
    filmcoll.delegate = self
    DispatchQueue.global().async {
      // Filmdaten asynchron laden
      self.films = Film.loadFilmsFromRss()
      DispatchQueue.main.async {
        // im Main-Thread Anzeige aktualisieren
        self.filmcoll.reloadData()
      }
    }
  }

  // Fokus-Management
  override func didUpdateFocus(
    in context: UIFocusUpdateContext,
    with coordinator: UIFocusAnimationCoordinator)
  {
    if let prev = context.previouslyFocusedItem as? MyCell {
      prev.markSelected(state: false)
    }
    
    // dafür ist nun dieses Steuerelement ausgewählt
    if let next = context.nextFocusedItem as? MyCell {
      next.markSelected(state: true)
    }
  }

}

extension ViewController : UICollectionViewDelegate,
                           UICollectionViewDataSource
{
  func numberOfSections(in collectionView: UICollectionView)
    -> Int
  {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int)
    -> Int
  {
    return films.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    let cell = filmcoll.dequeueReusableCell(
      withReuseIdentifier: "mycell", for: indexPath)
    cell.backgroundColor = unselectedColor
    if let mycell = cell as? MyCell {
      let n = indexPath.row
      mycell.title.text = films[n].title
      mycell.descr.text = films[n].descr
      mycell.img.image = nil
      if let url = films[n].imgLink {
        mycell.spinner.startAnimating()
        DispatchQueue.global().async {
          // asynchron Bild herunterladen
          if let bindata = try? Data(contentsOf: url) {
            DispatchQueue.main.async {
              // im Main-Thread setzen, Spinner stoppen
              mycell.img.image = UIImage(data: bindata)
              mycell.spinner.stopAnimating()
            }
          }
        }
        
      }
      
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath)
  {
    let n = indexPath.row
    print(films[n].filmLink)
    
    // Dialog zusammenstellen
    let alert = UIAlertController(
      title: "Sorry",
      message: "Diese App ist leider nicht in der Lage, " +
               "die Trailer tatsächlich abzuspielen.",
      preferredStyle: .alert)
    alert.addAction(
      UIAlertAction(title: "OK", style: .default, handler: nil))
    
    // Dialog anzeigen
    present(alert, animated: true, completion: nil)
  }
}
