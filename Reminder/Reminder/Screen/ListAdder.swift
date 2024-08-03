//
//  ListAdder.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/30/24.
//
import SwiftUI

struct ListAdder:View {
    @Environment(\.dismiss) private var dimiss
    @Environment(\.modelContext) private var context
    
    @State private var listName: String = ""
    @State private var color: Color = .clear
    
    var myList: MyList? = nil
    
    var body: some View {
        VStack{
            Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(color)
            
            TextField("List Name", text: $listName)
                .textFieldStyle(.roundedBorder)
                .padding([.leading, .trailing], 44)
            
            ColorPick(selectColor: $color)
        }
        .onAppear(perform: {
            if let myList {
                listName = myList.name
                color = Color(hex: myList.colored)
            }
        })
        .navigationTitle("New List")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button("Close"){
                    dimiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing){
                Button("Done"){
                    if let myList{
                        myList.name = listName
                        myList.colored = color.toHex() ?? ""
                    }else{
                        guard let hex = color.toHex() else { return }
                        let myList = MyList(name: listName, colored: hex)
                        context.insert(myList)
                    }
                    dimiss()
                }
            }
        }
    }
}

#Preview { @MainActor in
    NavigationStack{
        ListAdder()
    }.modelContainer(PrevContainer)
}
