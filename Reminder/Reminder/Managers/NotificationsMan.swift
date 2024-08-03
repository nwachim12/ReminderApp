//
//  NotificationsMan.swift
//  Reminder
// Manages the notifications for the app as it gets the details for the notifications and ask the user if they want notifications
//  Created by Michael Nwachi on 8/3/24.
//

import Foundation
import UserNotifications

struct UserData{
    let title: String?
    let body: String?
    let date:Date?
    let time: Date?
}

struct NotificationsMan{
    static func scheduleNofity(UserData: UserData){
        let content = UNMutableNotificationContent()
        content.title = UserData.title ?? "Notification from Reminders App"
        content.body = UserData.body ?? ""
        
        var dataDetails = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: UserData.date ?? Date())
        
        if let reminderTime = UserData.time{
            let reminderTimeDataDetails = reminderTime.dateComponents
            dataDetails.hour = reminderTimeDataDetails.hour
            dataDetails.minute = reminderTimeDataDetails.minute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dataDetails, repeats: false)
        let request = UNNotificationRequest(identifier: "Reminder Notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
