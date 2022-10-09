//
//  NoteItem.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import Foundation

struct NoteItem: Codable, Hashable, Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var date = Date()
    var dateText: String {
        return date.formatted()
    }
    var isPin: Bool = false
    var isSelected: Bool = false
}
