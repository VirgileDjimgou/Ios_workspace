//
//  TabBarController.swift
//  ios-tab-controller
//
//  Created by Michael Kofler on 13.05.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  
    // zum Datenaustausch zwischen den Tabs
    var somedata = 123

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}