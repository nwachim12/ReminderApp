//
//  ReminderListView.swift
//  Reminder
//  Shows the list of the reminders for the user
//  Created by Michael Nwachi on 7/31/24.
//

import SwiftUI
import SwiftData

struct ReminderListView: View {
    let reminders: [ReminderModel]
    @Environment(\.modelContext) private var context
    
    @State private var selectedReminder: ReminderModel? = nil
    @State private var showReminderScreen: Bool = false
    
    @State private var reminderIdandDelay: [PersistentIdentifier: Delay] = [: ]
    
    private func deleteRemind(_ indexSet: IndexSet){
        guard let index = indexSet.last else {return}
        let reminder = reminders[index]
        context.delete(reminder)
    }
    
    var body: some View {
        List{
            ForEach(reminders){ reminder in
                RemindCelView(reminder: reminder, isSelected: reminder == selectedReminder) {event in
                    switch event{
                    case .onChecked(let reminder, let checked):
                        
                        var delay = reminderIdandDelay[reminder.persistentModelID]
                        if let delay{
                            delay.cancel()
                            reminderIdandDelay.removeValue(forKey: reminder.persistentModelID)
                        }else{
                            delay = Delay()
                            reminderIdandDelay[reminder.persistentModelID] = delay
                            delay?.performWork {
                                reminder.isCompleted = checked
                            }
                        }
                    case .onSelect(let reminder):
                        selectedReminder = reminder
                    case .onInfoSelect(let reminder):
                        selectedReminder = reminder
                        showReminderScreen = true
                    }
                }
                }.onDelete(perform: deleteRemind)
            }.sheet(item: $selectedReminder, content: {
                selectedReminder in
                NavigationStack{
                    ReminderEditScreen(reminder: selectedReminder)
                }
            })
        }
    }
    
