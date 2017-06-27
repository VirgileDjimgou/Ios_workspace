//
//  ViewController.swift
//  ATerminal
//
//  Created by lijunge on 15/8/8.
//  Copyright © 2015年 A. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var objects = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        //UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation:.None) // deprecated
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.backgroundColor = UIColor.black
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 20//TODO
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view = tableView
        
        
        objects = [1 as AnyObject, 2 as AnyObject, 3 as AnyObject, 4 as AnyObject, 5 as AnyObject, 6 as AnyObject, 7 as AnyObject, 8 as AnyObject, 9, 10]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count;
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.black
        cell.contentView.addSubview(RowView(frame: cell.bounds))
        return cell
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

