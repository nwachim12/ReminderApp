//
//  ReminderModel.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/30/24.
//

import Foundation
import SwiftData

@Model
class ReminderModel {
    var title: String
    var notes: String?
    
    var isCompleted: Bool
    
    var reminderDate: Date?
    var reminderTime: Date?
    
    var list: MyList?
    
    init(title: String, notes: String? = nil, isCompleted: Bool = false, reminderDate: Date? = nil, reminderTime: Date? = nil, list: MyList? = nil) {
        self.title = title
        self.notes = notes
        self.isCompleted = isCompleted
        self.reminderDate = reminderDate
        self.reminderTime = reminderTime
        self.list = list
    }
}
