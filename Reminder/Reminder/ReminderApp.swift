//
//  ReminderApp.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/30/24.
//

import SwiftUI
import UserNotifications

@main
struct ReminderApp: App {
    
    init(){
        UNUserNotificationCenter.current().requestAuthorization(options:  [.alert, .sound, .badge]) { _, _ in
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ListAppIcon()
            }.modelContainer(for: MyList.self)
        }
    }
}
