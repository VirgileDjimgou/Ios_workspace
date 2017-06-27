//
//  ViewController.swift
//  Hello iOS
//
//  Created by Djimgou , Patrick on 30.04.17.
//  Copyright © 2017 Hochschule Aalen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var allButtons: [UIButton]!
    
    
    @IBOutlet weak var output2: UITextView!
    
    @IBAction func TestButton(_ sender: UIButton) {
        self.output2.text = ""
        
    }
    
    @IBAction func helloWorldClick(_ sender: UIButton) {
        
        dispatchAsyncTasks()    }
    
    
    @IBAction func newClick (_ sender : UIButton) {
        dispatchSyncTasks()
    }
 
   
        
        
    func dispatchAsyncTasks () {
        let concurrentQueue = DispatchQueue(label: "AsyncQueue", attributes: .concurrent)
        
        concurrentQueue.async {
            let calc = Funktionen()
            calc.performCalculation(iterations: 100_000_000, output: self.output2, tag: "Async 1")
        }
        
        concurrentQueue.async {
            let calc = Funktionen()
            calc.performCalculation(iterations: 20_000_000, output: self.output2, tag: "Async 2")
        }
        
        concurrentQueue.async {
            let calc = Funktionen()
            calc.performCalculation(iterations: 1_000_000, output: self.output2, tag: "Async 3")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.output2.text.append("One second since calculations started.\n")
        }
    }
    
    
    func dispatchSyncTasks () {
        let concurrentQueue = DispatchQueue(label: "SyncQueue", attributes: .concurrent)
        
        concurrentQueue.sync {
            let calc = Funktionen()
            calc.performCalculation(iterations: 100_000_000, output: self.output2, tag: "Sync 1")
        }
        
        concurrentQueue.sync {
            let calc = Funktionen()
            calc.performCalculation(iterations: 20_000_000, output: self.output2, tag: "Sync 2")
        }
        
        concurrentQueue.sync {
            let calc = Funktionen()
            calc.performCalculation(iterations: 1_000_000, output: self.output2, tag: "Sync 3")
        }
        
        DispatchQueue.once(token: "SyncQueue") {
            DispatchQueue.main.async { self.output2.text.append("This text is only printed once\n") }
        }
        
    }
    
    
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public static func once(token: String, block: (Void) -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }}

