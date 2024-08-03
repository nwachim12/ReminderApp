//
//  Delay.swift
//  Reminder
// Method creates a delay when deleting or hiding their reminder
//  Created by Michael Nwachi on 7/31/24.
//

import Foundation

class Delay{
    
    private var seconds: Double
    var workItem: DispatchWorkItem?
    
    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }
    
    func performWork(_ work: @escaping () -> Void){
        workItem = DispatchWorkItem(block: {
            work()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    
    func cancel(){
        workItem?.cancel()
    }
}
