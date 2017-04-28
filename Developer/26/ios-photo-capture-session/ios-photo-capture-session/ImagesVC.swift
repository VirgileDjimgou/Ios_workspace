//
//  ImagesVC.swift
//  ios-photo-capture-session
//
//  Created by Michael Kofler on 11.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ImagesVC: UIViewController {
  weak var mainVC: ViewController!
  
  @IBOutlet weak var collView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collView.delegate = self
    collView.dataSource = self
    
  }
}

extension ImagesVC: UICollectionViewDelegate,
                    UICollectionViewDataSource
{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mainVC.photos.count
  }
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    let cell = collView.dequeueReusableCell(
      withReuseIdentifier: "mycell",
      for: indexPath) as! PhotoCell
    cell.imgView.image = mainVC.photos[indexPath.row]
    return cell
  }
  
}
