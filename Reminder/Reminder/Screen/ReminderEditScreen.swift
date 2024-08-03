//
//  ReminderEditScreen.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/31/24.
//

import SwiftUI
import SwiftData

struct ReminderEditScreen: View {
    @Environment(\.dismiss) private var dimiss
    let reminder: ReminderModel
    
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var reminderDate: Date = .now
    @State private var reminderTime: Date = .now
    
    @State private var showCalenderIcon: Bool = false
    @State private var showTimeIcon: Bool = false
    
    private func updateReminder(){
        reminder.title = title
        reminder.notes = notes.isEmpty ? nil: notes
        reminder.reminderDate = showCalenderIcon ? reminderDate: nil
        reminder.reminderDate = showTimeIcon ? reminderTime: nil
        
        NotificationsMan.scheduleNofity(UserData: UserData(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminderTime))
    }
    
    private var isFormValid: Bool{
        !title.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        Form{
            Section{
                TextField("Title", text: $title)
                TextField("Notes", text: $notes)
            }
            Section{
                HStack{
                    Image(systemName: "calender")
                        .foregroundStyle(.red)
                        .font(.title2)
                    Toggle(isOn: $showCalenderIcon){
                        EmptyView()
                    }
                }
                if showCalenderIcon{
                    DatePicker("Select Date", selection: $reminderDate, in: .now..., displayedComponents: .date)
                }
                HStack{
                    Image(systemName: "clock")
                        .foregroundStyle(.blue)
                        .font(.title2)
                    Toggle(isOn: $showTimeIcon){
                        EmptyView()
                    }
                }.onChange(of: showTimeIcon){
                    if showTimeIcon{
                        showCalenderIcon = true
                    }
                }
                if showTimeIcon{
                    DatePicker("Select Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                }
            }
        }.onAppear(perform: {
            title = reminder.title
            notes = reminder.notes ?? ""
            reminderDate = reminder.reminderDate ?? Date()
            reminderTime = reminder.reminderTime ?? Date()
            showCalenderIcon = reminder.reminderDate != nil
            showTimeIcon = reminder.reminderTime != nil
        })
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button("Close"){
                    dimiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing){
                Button("Done"){
                    updateReminder()
                    dimiss()
                }.disabled(!isFormValid)
            }
        }
    }
}

struct ReminderEditScreenContainer: View {
    @Query(sort: \ReminderModel.title) private var reminders: [ReminderModel]
    var body: some View{
        ReminderEditScreen(reminder: reminders[0])
    }
}

#Preview {
    NavigationStack{
        ReminderEditScreenContainer()
    }.modelContainer(PrevContainer)
}
