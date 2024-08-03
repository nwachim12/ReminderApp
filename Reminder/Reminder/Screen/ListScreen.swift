//
//  ListScreen.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/30/24.
//

import SwiftUI
import SwiftData

enum ReminderStatsType: Int, Identifiable{
    case today
    case scheduled
    case all
    case completed
    
    var id: Int{
        self.rawValue
    }

var title: String {
    switch self {
    case .today:
        return "Today"
    case .scheduled:
        return "Scheduled"
    case .all:
        return "All"
    case .completed:
        return "Completed"
        }
    }
}
struct ListAppIcon: View{
    
    @Query private var myLists: [MyList]
    @State private var Presented: Bool = false
    @State private var selectedList: MyList?
    
    @State private var actionSheet: ListScreenSheets?
    
    @Query private var reminders: [ReminderModel]
    @State private var reminderStatsType: ReminderStatsType?
    
    
    enum ListScreenSheets: Identifiable{
        case newList
        case editList(MyList)
        
        var id: Int{
            switch self{
            case .newList:
                return 1
            case .editList(let myList):
                return myList.hashValue
            }
        }
    }
    private var inCompleted: [ReminderModel]{
        reminders.filter { !$0.isCompleted}
    }
    
    private var todaysReminder: [ReminderModel]{
        reminders.filter {
            guard let reminderDate = $0.reminderDate else {
                return false
            }
            return reminderDate.isToday && !$0.isCompleted
        }
    }
    
    private var scheduledReminder: [ReminderModel]{
        reminders.filter {
            $0.reminderDate != nil && !$0.isCompleted
        }
    }
    
    private var completedReminder: [ReminderModel]{
        reminders.filter {$0.isCompleted}
    }
    
    private func reminders(for type: ReminderStatsType) -> [ReminderModel]{
        switch type{
            case .all:
                return inCompleted
            case.scheduled:
                return scheduledReminder
            case .today:
                return todaysReminder
            case .completed:
                return completedReminder
        }
    }
    var body: some View{
        List{
            VStack{
                HStack{
                    ReminderBoxStatsView(icon:"calender", title: "Today", count: todaysReminder.count)
                        .onTapGesture {
                            reminderStatsType = .today
                        }
                    ReminderBoxStatsView(icon:"calender.circle.fill", title: "Scheduled", count: scheduledReminder.count)
                        .onTapGesture {
                            reminderStatsType = .scheduled
                        }
                    ReminderBoxStatsView(icon:"tray.circle.fill", title: "All", count: inCompleted.count)
                        .onTapGesture {
                            reminderStatsType = .all
                        }
                    ReminderBoxStatsView(icon:"checkmark.circle.fill", title: "Completed", count: completedReminder.count)
                        .onTapGesture {
                            reminderStatsType = .completed
                        }
                }
            }
            
            ForEach(myLists){
                myList in
                
                NavigationLink(value: myList){
                    ListCellView(myList: myList)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedList = myList
                        }
                        .onLongPressGesture(minimumDuration: 0.5){
                            actionSheet = .editList(myList)
                        }
                }
            }
            
            Button(action:{
                actionSheet = .newList
            }, label: {
                Text("Create New List")
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }).listRowSeparator(.hidden)
            
        }
        .navigationTitle("My Lists")
        .navigationDestination(item: $selectedList, destination: {
            myList in DetailScreen(MyList: myList)
        })
        .navigationDestination(item: $reminderStatsType, destination: { reminderStatsType in
            NavigationStack{
                ReminderListView(reminders: reminders(for: reminderStatsType))
                    .navigationTitle(reminderStatsType.title)
            }
        })
        .listStyle(.plain)
        .sheet(item: $actionSheet){
            actionSheet in switch actionSheet {
            case .newList:
                NavigationStack{
                    ListAdder()
                }
            case .editList(let myList):
                NavigationStack{
                    ListAdder(myList: myList)
                }
            }
        }
    }
}

    #Preview{ @MainActor in
        NavigationStack{
            ListAppIcon()
        }.modelContainer(PrevContainer)
    }

#Preview("Dark Mode"){ @MainActor in
    NavigationStack{
        ListAppIcon()
    }.modelContainer(PrevContainer)
    .environment(\.colorScheme, .dark)
}

struct ListCellView: View {
    let myList: MyList
    
    var body: some View {
        HStack{
            Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(size: 32))
                .foregroundColor(Color(hex: myList.colored))
            Text(myList.name)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
    

