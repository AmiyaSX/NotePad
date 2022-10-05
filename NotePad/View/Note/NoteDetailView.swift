//
//  NoteDetailView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI
import MarkdownUI

//支持Markdown
struct NoteDetailView: View {
    @Binding var note: NoteItem
    @State var title: String
    @State var content: String
    
    var body: some View {
        VStack {
            TextField("NoteTitle", text: $title, prompt: Text("Title"))
                .font(.title)
                .padding(.horizontal)
            Text(note.dateText).font(.footnote).frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.gray)
                .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
            Divider().padding(.horizontal)
            TextField("NoteContent", text: $content, prompt: Text("Type here to start..."))
                .padding(.init(top: 0, leading: 20, bottom: 500, trailing: 20))
                .lineLimit(nil)
            Divider()
        }
        .navigationBarItems(trailing: Image(systemName: "doc.on.doc").onTapGesture {
            note.title = title
            note.content = content
            note.date = Date()
        })
        .frame(maxHeight: .infinity, alignment: .topLeading)
            
        
    }
}

