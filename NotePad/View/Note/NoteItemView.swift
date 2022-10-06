//
//  NoteItemView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct NoteItemView: View {
    let item: NoteItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.headline)
                .padding(.top)
                .padding(.leading)
            Divider().frame(width: 100, alignment: .leading).padding(.leading)
            Spacer()
            Text(item.content)
                .font(.subheadline)
                .lineLimit(nil)
                .multilineTextAlignment(.leading).padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text(item.dateText)
                .font(.caption2)
                .italic()
                .lineLimit(nil)
                .multilineTextAlignment(.leading).padding(.trailing).padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }.background(Color(UIColor(named: item.isPin ? "NotePinColor" : "CardColor2")!))
         .cornerRadius(20)
    }
}
