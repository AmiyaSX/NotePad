//
//  NoteViewModel.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/5.
//

import Foundation
import Combine
import SwiftUI

class NoteViewModel: ObservableObject {
    @Published var notesToDelete: [NoteItem]?
    @Published var showAlert = false
    @Published var isEditable = false
    @Published var newNote: NoteItem
    @Published var selectNotes = Set<NoteItem>()
    @Published var noteItems: [NoteItem] = []
    
    static let shared = NoteViewModel()
    
    private init() {
        newNote = NoteItem(title: "Title", content: "")
    }
    
    private func addNewNote() {
//        let id = noteItems.reduce(0) { max($0, $1.id) } + 1
        newNote = NoteItem(title: "Title",content: "", date: Date())
    }
    
    func findItemIdex(item: NoteItem) -> Int {
        noteItems.firstIndex(of: item) ?? -1
    }
    
    func addNote() {
        noteItems.insert(newNote, at: 0)
        addNewNote()
    }
    
    func moveNote(from source: IndexSet, to destination: Int) {
        noteItems.move(fromOffsets: source, toOffset: destination)
        withAnimation {
            isEditable = false
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        noteItems.remove(atOffsets: offsets)
    }
    
    func deleteNotes() {
        guard let notesToDelete = notesToDelete else { return }
        noteItems = noteItems.filter { !notesToDelete.contains($0) }
    }
    
    func deleteSelectNotes() {
        noteItems = noteItems.filter { !selectNotes.contains($0) }
    }
    
    func pinNotes() {
        for item in noteItems {
            if (selectNotes.contains(item)) {
                noteItems[findItemIdex(item: item)].isPin.toggle()
            }
        }
    }
    
    func dataUpdate() {
        let user = UserDefaults.standard.string(forKey: "identify")
        noteItems = {
            guard let data = UserDefaults.standard.data(forKey: "\(String(describing: user))notes") else { return [] }
            if let json = try? JSONDecoder().decode([NoteItem].self, from: data) {
                return json
            }
            return []
        }()
    }
    
    func saveNotes() {
        let user = UserDefaults.standard.string(forKey: "identify")
        noteItems = noteItems.sorted(by: { (lhs, rhs) -> Bool in
            lhs.isPin
        })  //置顶效果
        guard let data = try? JSONEncoder().encode(noteItems) else { return }
        UserDefaults.standard.set(data, forKey: "\(String(describing: user))notes")
    }
}
