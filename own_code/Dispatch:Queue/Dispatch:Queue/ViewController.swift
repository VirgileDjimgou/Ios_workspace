//
//  ViewController.swift
//  Dispatch:Queue
//
//  Created by Mac OS on 03.05.17.
//  Copyright © 2017 Djimgou Patrick. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    
    func doCalc() {
        var x=100
        var y=x*x
        _ = y/x
    }

    func performCalculation (iterations: Int, output: UITextView, tag: String) {
        let start = CFAbsoluteTimeGetCurrent()
        for value in 0 ..< iterations {
            self.doCalc()
        }
        let end = CFAbsoluteTimeGetCurrent()
        DispatchQueue.main.async {
            output.text.append("Time for \(tag):  \(String(format: "%2.2f", end-start)) seconds\n")
        }
    }
    
   
    
    func dispatchAsyncTasks () {
        let concurrentQueue = DispatchQueue(label: "AsyncQueue", attributes: .concurrent)
        
       
    }
    
    
    func dispatchSyncTasks () {
        let concurrentQueue = DispatchQueue(label: "SyncQueue", attributes: .concurrent)
        
       
        
    }
    
    
    @IBAction func dispatch_asynchone(_ sender: Any) {
        
        
        
        
    }
    
    
    @IBAction func Concurrent_queue(_ sender: Any) {
    }
    
    
    @IBAction func Serial_dipatch_queue(_ sender: Any) {
    }
    
    
    @IBAction func Example_4(_ sender: Any) {
    }
    
    
    @IBOutlet weak var output: UITextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

