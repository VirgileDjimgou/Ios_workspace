//
//  ViewController.swift
//  Concurrency
//
//  Created by Bergen, Dominik on 24.11.16.
//  Copyright © 2016 Hochschule Aalen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBAction func runAsyncTasks(_ sender: AnyObject) {
        dispatchAsyncTasks()
    }
    
    @IBAction func runSyncTasks(_ sender: AnyObject) {
        dispatchSyncTasks()
    }
    
    func dispatchAsyncTasks () {
        let concurrentQueue = DispatchQueue(label: "AsyncQueue", attributes: .concurrent)
        
        concurrentQueue.async {
            let calc = Calculator()
            calc.performCalculation(iterations: 100_000_000, output: self.textView, tag: "Async 1")
        }
        
        concurrentQueue.async {
            let calc = Calculator()
            calc.performCalculation(iterations: 20_000_000, output: self.textView, tag: "Async 2")
        }
        
        concurrentQueue.async {
            let calc = Calculator()
            calc.performCalculation(iterations: 1_000_000, output: self.textView, tag: "Async 3")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.textView.text.append("One second since calculations started.\n")
        }
    }
    
    func dispatchSyncTasks () {
        let concurrentQueue = DispatchQueue(label: "SyncQueue", attributes: .concurrent)
        
        concurrentQueue.sync {
            let calc = Calculator()
            calc.performCalculation(iterations: 100_000_000, output: self.textView, tag: "Sync 1")
        }
        
        concurrentQueue.sync {
            let calc = Calculator()
            calc.performCalculation(iterations: 20_000_000, output: self.textView, tag: "Sync 2")
        }
        
        concurrentQueue.sync {
            let calc = Calculator()
            calc.performCalculation(iterations: 1_000_000, output: self.textView, tag: "Sync 3")
        }
        
        DispatchQueue.once(token: "SyncQueue") {
            DispatchQueue.main.async { self.textView.text.append("This text is only printed once\n") }
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
    }
}
