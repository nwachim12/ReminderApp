//
//  MyList.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/30/24.
//
import Foundation
import SwiftData

@Model
class MyList{
     
    var name: String
    var colored: String
    
    @Relationship(deleteRule: .cascade)
    var reminders: [ReminderModel] = []
    
    init(name: String, colored: String){
        self.name = name
        self.colored = colored
    }
}


