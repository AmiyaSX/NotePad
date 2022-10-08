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
    @EnvironmentObject private var loginViewModel: LoginViewModel
    @Environment(\.editMode) private var editMode
    @State var searchQuery = ""
    @State var fliterNotes = NoteViewModel.shared.noteItems
    private var disableDelete: Bool {
        if let mode = editMode?.wrappedValue, mode == .active {
            return true
        }
        return false
    }
    private var TrailingMenu: some View {
        return HStack {
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
                    Button("Logout", action: {
                        loginViewModel.needLogin = true
                    })
                } label: {
                    Label("Menu", systemImage: "ellipsis")
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List(selection: $noteViewModel.selectNotes) {
                    ForEach(noteViewModel.noteItems, id: \.self) { item in
                        if (item.title.localizedCaseInsensitiveContains(searchQuery) || searchQuery == "" || item.content.localizedCaseInsensitiveContains(searchQuery)) {
                            ZStack {
                                NavigationLink(destination:  NoteDetailView(note: $noteViewModel.noteItems[noteViewModel.findItemIdex(item: item)], title: noteViewModel.noteItems[noteViewModel.findItemIdex(item: item)].title, content: noteViewModel.noteItems[noteViewModel.findItemIdex(item: item)].content)) {
                                }.opacity(0)
                                NoteItemView(item: item)
                            }.listRowBackground(Color.white)
                        }
                    }.onDelete(perform: noteViewModel.deleteNote)
                    .onMove(perform: noteViewModel.moveNote)
                    .deleteDisabled(true)
                    .listRowSeparator(.hidden)
                }.listStyle(.plain)
                    .navigationBarItems(leading: UserView().frame(maxWidth: .infinity, alignment: .leading), trailing: TrailingMenu).environment(\.editMode, editMode)
                NavigationLink(destination: NoteCreateView(note: $noteViewModel.newNote, title: noteViewModel.newNote.title, content: noteViewModel.newNote.content), label: {
                     Image(systemName: "plus")
                         .imageScale(.large)
                         .foregroundColor(.white)
                         .frame(width: 50, height: 50, alignment:.center)
                         .background(Color.orange)
                         .clipShape(Circle()).padding(12)
                         .shadow(color: .primary, radius: 60, x: 0.1, y: 0.1)
                 })
            }
            .navigationTitle("Notes (\(NoteViewModel.shared.noteItems.count))")
            .onChange(of: noteViewModel.noteItems, perform: { _ in
                noteViewModel.saveNotes()
            })
        }.searchable(text: $searchQuery, prompt: "Search By Keywords")
        
    }

}

