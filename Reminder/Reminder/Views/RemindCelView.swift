//
//  RemindCelView.swift
//  Reminder
// 
//  Created by Michael Nwachi on 7/30/24.
//

import SwiftUI
import SwiftData

enum RemindCellEvents{
    case onChecked(ReminderModel, Bool)
    case onSelect(ReminderModel)
    case onInfoSelect(ReminderModel)
}

struct RemindCelView: View {
    
    let reminder: ReminderModel
    let isSelected: Bool 
    let onEvent: (RemindCellEvents) -> Void
    @State private var checked: Bool = false
    
    let delay = Delay()
    
    private func formatReminderDate(_ date: Date) -> String{
        if date.isToday{
            return "Today"
        }else if date.isTomorrow{
            return "Tomorrow"
        }else{
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    var body: some View {
        HStack(alignment: .top){
            
            Image(systemName: checked ? "circle.inset.filled": "circle")
                .font(.title2)
                .padding((.trailing), 5)
                .onTapGesture {
                    checked.toggle()
                    onEvent(.onChecked(reminder, checked))
                }
            
            VStack{
                Text(reminder.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let notes = reminder.notes{
                    Text(notes)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    if let reminderDate = reminder.reminderDate{
                        Text(formatReminderDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime{
                        Text(reminderTime, style: .time)
                    }
                }.font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1: 0)
                .onTapGesture {
                    onEvent(.onInfoSelect(reminder))
                }
            
        }.contentShape(Rectangle())
            .onTapGesture {
                onEvent(.onSelect(reminder))
            }
    }
}

struct RemindCelViewContainer: View {
    @Query(sort: \ReminderModel.title) private var reminders: [ReminderModel]
    var body: some View {
        RemindCelView(reminder: reminders[0], isSelected: false) { _ in
            
        }
    }
}

#Preview { @MainActor in
    RemindCelViewContainer()
        .modelContainer(PrevContainer)
}
