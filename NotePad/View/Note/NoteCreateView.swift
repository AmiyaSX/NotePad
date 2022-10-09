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
    @State private var content: String = "\n"
    @State private var isEditing: Bool = false
    private var TrailingMenu: some View {
        return HStack {
            if (isEditing) {
                Image(systemName: "pencil.slash").onTapGesture {
                    if (content.last != "\n") {
                        content.append("\n")
                    }
                    isEditing.toggle()
                }
            } else {
                Image(systemName: "pencil").onTapGesture {
                    isEditing.toggle()
                }
            }
            Image(systemName: "doc.on.doc").onTapGesture {
                if (content.last != "\n") {
                    content.append("\n")
                }
                note.title = title
                note.content = content
                note.date = Date()
                noteViewModel.addNote()
                presentationMode.wrappedValue.dismiss() //解决子视图返回根视图问题
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
                        TextEditor(text: $content)
                            .padding(.init(top: 0, leading: 20, bottom: 200, trailing: 20))
                            .scrollContentBackground(.hidden)
                            .lineSpacing(4)
                            .lineLimit(nil)
                    } else {
                        HStack {
                            if (content == "\n") {
                                Text("Type something to start...").fixedSize().foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Markdown(content)
                                    .setImageHandler(.assetImage(), forURLScheme: "asset")
                            }
                        }.padding(.horizontal)
                    }
                }.frame(maxHeight: .infinity, alignment: .topLeading)
            }
        }.navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: TrailingMenu)
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}

