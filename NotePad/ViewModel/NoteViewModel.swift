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
    @State var selectNotes = Set<NoteItem>()
    @Published var noteItems: [NoteItem] = {
        guard let data = UserDefaults.standard.data(forKey: "notes") else { return [] }
        if let json = try? JSONDecoder().decode([NoteItem].self, from: data) {
            return json
        }
        return []
    }()
    
    static let shared = NoteViewModel()
    
    private init() {
        newNote = NoteItem(id: -1, title: "Title", content: "")
    }
    
    func findItemIdex(item: NoteItem) -> Int {
        NoteViewModel.shared.noteItems.firstIndex(of: item) ?? -1
    }
    
    func didTapAddNote() {
        let id = noteItems.reduce(0) { max($0, $1.id) } + 1
        newNote = NoteItem(id: id, title: "Title",content: "", date: Date())
    }
    
    func addNote() {
        noteItems.insert(newNote, at: 0)
        didTapAddNote()
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
    
    func saveNotes() {
        guard let data = try? JSONEncoder().encode(noteItems) else { return }
        UserDefaults.standard.set(data, forKey: "notes")
    }
}
