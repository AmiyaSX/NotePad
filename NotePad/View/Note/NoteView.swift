//
//  NotesView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI
import Combine

struct NoteView: View {
    
    @EnvironmentObject private var noteViewModel: NoteViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(NoteViewModel.shared.noteItems, id: \.self) { item in
                        ZStack {
                            NavigationLink(destination:  NoteDetailView(note: $noteViewModel.noteItems[noteViewModel.findItemIdex(item: item)], title: noteViewModel.noteItems[noteViewModel.findItemIdex(item: item)].title, content: noteViewModel.noteItems[noteViewModel.findItemIdex(item: item)].content)) {
                            }.opacity(0)
                            NoteItemView(item: item)
                        }
                      
                    }.onDelete(perform: noteViewModel.deleteNote)
                     .onMove(perform: noteViewModel.moveNote)
//                     .onLongPressGesture {
//                        withAnimation {
//                            noteViewModel.isEditable = true
//                        }
//                     }
                     .listRowSeparator(.hidden)
                }.listStyle(.plain)
                 .navigationTitle("Notes")
                 .toolbar { EditButton() }
                Button(action: noteViewModel.didTapAddNote, label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50, alignment:.center)
                        .background(Color.yellow)
                        .clipShape(Circle())
                }).padding(12)
            }.onChange(of: noteViewModel.noteItems, perform: { _ in
                noteViewModel.saveNotes()
            })
        }
    }

}

