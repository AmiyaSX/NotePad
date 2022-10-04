//
//  NotesView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct NoteView: View {
    @State var notesToDelete: [NoteItem]?
    @State var showAlert = false
    @State var noteItems: [NoteItem] = {
           guard let data = UserDefaults.standard.data(forKey: "notes") else { return [] }
           if let json = try? JSONDecoder().decode([NoteItem].self, from: data) {
               return json
           }
           return []
       }()
    
    var alert: Alert {
           Alert(title: Text("Hey!"),
                 message: Text("Are you sure you want to delete?"),
                 primaryButton: .destructive(Text("Delete"), action: deleteNotes),
                 secondaryButton: .cancel())
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(noteItems, id: \.self) { item in
                        NoteItemView(item: item).onLongPressGesture {
                            self.notesToDelete = [item]
                            self.showAlert = true
                        }
                    }.onDelete(perform: deleteNote)
                }.alert(isPresented: $showAlert, content: {
                                alert
                })
                Button(action: didTapAddNote, label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50, alignment:.center)
                        .background(Color.yellow)
                        .clipShape(Circle())
                }).padding(12)
            }
        }
    }
    
    func didTapAddNote() {
        let id = noteItems.reduce(0) { max($0, $1.id) } + 1
        noteItems.insert(NoteItem(id: id, title: "NoteTitle\(id)", content: "NoteText\(id)"), at: 0)
        saveNotes()
    }
    
    func deleteNote(at offsets: IndexSet) {
        noteItems.remove(atOffsets: offsets)
        saveNotes()
    }
    
    func deleteNotes() {
        guard let notesToDelete = notesToDelete else { return }
        noteItems = noteItems.filter { !notesToDelete.contains($0) }
        saveNotes()
    }
    
    func saveNotes() {
        guard let data = try? JSONEncoder().encode(noteItems) else { return }
        UserDefaults.standard.set(data, forKey: "notes")
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
