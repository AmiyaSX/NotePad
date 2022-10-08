//
//  NoteCreateView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/6.
//

import SwiftUI
import MarkdownUI

struct NoteCreateView: View {
    @Binding var note: NoteItem
    @EnvironmentObject var noteViewModel: NoteViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var title: String
    @State var content: String
    @State var isEditing: Bool = false
    
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
                if (isEditing) {
                    TextEditor(text: $content)
                        .padding(.init(top: 0, leading: 20, bottom: 200, trailing: 20))
                        .lineLimit(200)
                        .onSubmit {
                            isEditing = false
                        }
                } else {
                    HStack {
                        if (content == "") {
                            Text("Type here to start...").fixedSize().foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            Markdown(content)
                        }
                    }.onTapGesture {
                        isEditing = true
                    }.padding(.horizontal)
                }
            }
        }
        .navigationBarItems(trailing: Image(systemName: "doc.on.doc").onTapGesture {
            note.title = title
            note.content = content
            note.date = Date()
            noteViewModel.addNote()
            presentationMode.wrappedValue.dismiss() //解决子视图返回根视图问题
        })
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}

