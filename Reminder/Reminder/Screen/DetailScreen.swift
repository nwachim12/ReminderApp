//
//  DetailScreen.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/30/24.
//

import SwiftUI
import SwiftData

struct DetailScreen: View {
    
    @State private var title: String = ""
    @State private var isAlertPresented: Bool = false
    @State private var selectedReminder: ReminderModel?
    @State private var showReminderScreen: Bool = false
    
    @Environment(\.modelContext) private var context
    
    private let delay = Delay(seconds: 2.50)
    
    private var isFormValid: Bool{
        !title.isEmptyOrWhiteSpace
    }
    
    private func saveReminder(){
        let reminder = ReminderModel(title: title)
        MyList.reminders.append(reminder)
    }
    let MyList: MyList
    
    private func isReminderSelected(_ reminder: ReminderModel) -> Bool {
        reminder.persistentModelID == selectedReminder?.persistentModelID
    }
    
    private func deleteRemind(_ indexSet: IndexSet){
        guard let index = indexSet.last else {return}
        let reminder = MyList.reminders[index]
        context.delete(reminder)
    }
    
    var body: some View {
        VStack{
            
            ReminderListView(reminders: MyList.reminders.filter{!$0.isCompleted})
            
            Spacer()
            Button(action: {
                isAlertPresented = true
            }, label:{
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("New Reminder")
                }
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            
        }
            .alert("New Reminder", isPresented: $isAlertPresented){
                TextField("", text: $title)
                Button("Cancel", role: .cancel){}
                Button("Done"){
                    if isFormValid{
                        saveReminder()
                        title = ""
                    }
                }
            }
            .navigationTitle(MyList.name)
            .sheet(isPresented: $showReminderScreen, content: {
                if let selectedReminder {
                    NavigationStack {
                        ReminderEditScreen(reminder: selectedReminder)
                    }
                }
            })
    }
}

struct DetailScreenContainer: View {
    @Query private var MyList: [MyList]
    
    var body: some View {
        DetailScreen(MyList: MyList[0])
    }
}

#Preview { @MainActor in
    NavigationStack{
        DetailScreenContainer()
    }.modelContainer(PrevContainer)
}
