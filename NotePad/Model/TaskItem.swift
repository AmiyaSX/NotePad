//
//  TaskItem.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import Foundation

struct TaskItem: Codable, Hashable, Identifiable {
    let id: Int
    var title: String
    var content: String
    var date = Date()
    var dateText: String {
        return date.formatted()
    }
    var isComleted: Bool = false
    var isPin: Bool = false
    var isSelected: Bool = false
}
