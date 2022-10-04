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
            Spacer()
            Text(item.dateText)
                .font(.footnote)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
        }
    }
}
