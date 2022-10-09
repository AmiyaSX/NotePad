//
//  NoteDetailView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI
import UIKit
import MarkdownUI

//支持Markdown
struct NoteDetailView: View {
    @Binding var note: NoteItem
    @State var title: String
    @State var content: String
    @State var isEditing: Bool = false
    private var TrailingMenu: some View {
        return HStack {
            if (isEditing) {
                Image(systemName: "pencil.slash").onTapGesture {
                    content.append("\n")
                    isEditing.toggle()
                }
            } else {
                Image(systemName: "pencil").onTapGesture {
                    isEditing.toggle()
                }
            }
            Image(systemName: "doc.on.doc").onTapGesture {
                    content.append("\n")
                    note.title = title
                    note.content = content
                    note.date = Date()
            }
        }
    }
    var body: some View {
        ZStack {
            VStack {
                TextField("NoteTitle", text: $title, prompt: Text("Title"))
                    .font(.title)
                    .padding(.horizontal)
                Text(note.dateText).font(.footnote).frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                Divider().padding(.horizontal)
                ScrollView {
                    if (isEditing) {
                        VStack {
                            TextEditor(text: $content)
                                .scrollContentBackground(.hidden)
                                .padding(.init(top: 0, leading: 20, bottom: 200, trailing: 20))
                                .lineSpacing(4)
                                .lineLimit(nil)
                                
                        }
                   } else {
                       HStack {
                           if (content == "") {
                               Text("Type something to start...").fixedSize().foregroundColor(.gray)
                                   .frame(maxWidth: .infinity, alignment: .leading)
                           } else {
                               Markdown(content)
                           }
                       }.padding(.horizontal)
                   }
                }
            }.frame(maxHeight: .infinity, alignment: .topLeading)
        }.navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: TrailingMenu)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(note.isPin ? Color(UIColor(named: "NotePinColor" )!) : Color.white)
//        .padding(.bottom)
            
    }
}

