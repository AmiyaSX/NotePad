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
    @Environment(\.editMode) private var editMode
    var disableDelete: Bool {
        if let mode = editMode?.wrappedValue, mode == .active {
            return true
        }
        return false
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List(selection: $noteViewModel.selectNotes) {
                    ForEach(noteViewModel.noteItems, id: \.self) { item in
                        ZStack {
                            NavigationLink(destination:  NoteDetailView(note: $noteViewModel.noteItems[noteViewModel.findItemIdex(item: item)], title: noteViewModel.noteItems[noteViewModel.findItemIdex(item: item)].title, content: noteViewModel.noteItems[noteViewModel.findItemIdex(item: item)].content)) {
                            }.opacity(0)
                            NoteItemView(item: item)
                        }.listRowBackground(Color.white)
                    }.onDelete(perform: noteViewModel.deleteNote)
                    .onMove(perform: noteViewModel.moveNote)
                    .deleteDisabled(true)
                    .listRowSeparator(.hidden)
                }.listStyle(.plain)
                .toolbar {
                    HStack {
                        if (editMode?.wrappedValue == .active) {
                            Button(action: noteViewModel.deleteSelectNotes, label: {
                                Image(systemName: "trash")
                            })
                            Button(action: noteViewModel.pinNotes, label: {
                                Image(systemName: "pin")
                            })
                        }
                        EditButton()
                        if (editMode?.wrappedValue == .inactive) {
                            Menu {
                                Button("Import from Clipboard", action: {
                                    
                                })
                                Button("Save to iCloud", action: {
                                    
                                })
                            } label: {
                                Label("Menu", systemImage: "ellipsis")
                            }
                        }
                    }
                }.environment(\.editMode, editMode)
                NavigationLink(destination: NoteCreateView(note: $noteViewModel.newNote, title: noteViewModel.newNote.title, content: noteViewModel.newNote.content), label: {
                     Image(systemName: "plus")
                         .imageScale(.large)
                         .foregroundColor(.white)
                         .frame(width: 50, height: 50, alignment:.center)
                         .background(Color.yellow)
                         .clipShape(Circle()).padding(12)
                         .shadow(color: .primary, radius: 60, x: 0.1, y: 0.1)
                 })
            }
            .navigationTitle("Notes (\(NoteViewModel.shared.noteItems.count))")
            .onChange(of: noteViewModel.noteItems, perform: { _ in
                noteViewModel.saveNotes()
            })
        }
    }

}

