//
//  PrevContainer.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/30/24.
//
import Foundation
import SwiftData

@MainActor
var PrevContainer: ModelContainer = {
    
    let container = try! ModelContainer(for: MyList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    for myList in SampleData.myLists{
        container.mainContext.insert(myList)
        myList.reminders = SampleData.Reminder
    }
    
    return container
}()

struct SampleData{
    
    static var myLists: [MyList]{
        return [MyList(name:"Reminders", colored: "#34C759"), MyList(name: "Backlog", colored: "#AF52DE")]
    }
    
    static var Reminder: [ReminderModel] {
        return [ReminderModel(title: "Reminder 1", notes:"Reminder 1 notes", reminderDate: Date(), reminderTime: Date()), ReminderModel(title: "Reminder 2", notes: "Wow")]
    }
}

