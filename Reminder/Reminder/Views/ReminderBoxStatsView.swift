//
//  ReminderBoxStatsView.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/31/24.
//

import SwiftUI

struct ReminderBoxStatsView: View {
    let icon: String
    let title: String
    let count: Int
    
    var body: some View {
        GroupBox{
            HStack{
                VStack(spacing: 10){
                    Image(systemName: icon)
                    Text(title)
                }
                Spacer()
                Text("\(count)")
                    .font(.largeTitle)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ReminderBoxStatsView(icon: "calender", title: "Today", count: 9)
}
