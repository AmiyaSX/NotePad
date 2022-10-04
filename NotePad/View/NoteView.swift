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
            List(noteItems) { item in
                VStack(alignment: .leading) {
                    Text(item.dateText).font(.headline)
                    Text(item.content).lineLimit(nil).multilineTextAlignment(.leading)
                }.onLongPressGesture {
                        self.notesToDelete = [item]
                        self.showAlert = true
                    }
                }.alert(isPresented: $showAlert, content: {
                            alert
                })
            Button(action: didTapAddNote, label: { Text("Add") }).padding(8)
        }
    }
    
    func didTapAddNote() {
        let id = noteItems.reduce(0) { max($0, $1.id) } + 1
        noteItems.insert(NoteItem(id: id, title: "NoteTitle", content: "NoteText"), at: 0)
        saveNotes()
    }
    
    func deleteNotes() {
          guard let notesToDelete = notesToDelete else { return }
          noteItems = notesToDelete.filter { !$0.isToDelete }
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
