//
//  ColorPick.swift
//  Reminder
// File used to create a color pick for the file color for the user
//  Created by Michael Nwachi on 7/30/24.
//
import SwiftUI

struct ColorPick: View {
    
    @Binding var selectColor: Color
    
    let colors: [Color] = [.green, .red, .blue, .yellow, .purple, .orange]
    
    var body: some View {
        HStack{
            ForEach(colors, id: \.self) {
                color in ZStack{
                    Circle().fill()
                        .foregroundColor(color)
                        .padding(2)
                    Circle()
                        .strokeBorder(selectColor.toHex() == color.toHex() ? .gray: .clear, lineWidth: 4)
                        .scaleEffect(CGSize(width: 1.15, height: 1.15))
                }.onTapGesture {
                    selectColor = color
                }
            }
        }.padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
    }
}

struct ColorPick_Preview: PreviewProvider{
    static var previews: some View{
        ColorPick(selectColor: .constant(.yellow))
    }
}

