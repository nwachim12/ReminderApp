//
//  Date+Extension.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/31/24.
//

import Foundation

extension Date {
    var isToday: Bool {
        let calender = Calendar.current
        return calender.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        let calender = Calendar.current
        return calender.isDateInTomorrow(self)
    }
    
    var dateComponents:DateComponents{
        Calendar.current.dateComponents([.year, .month, .day, .hour, . minute], from: self)
    }
}
