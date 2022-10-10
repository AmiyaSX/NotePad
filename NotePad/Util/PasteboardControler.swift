//
//  PasteboardControler.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/9.
//

import Foundation
import SwiftUI
import UIKit

class PasteboardControler {
    
    let pasteboard = UIPasteboard.general
    /* format eg(begin with '#' end with ':wq\n'):
         # 🏝
         Content
         :wq
         # 🎠
         Yyyyyyy
         :wq
         # 🗽
         jascjaui
         :wq
     */
    func importNotesfromPasteboard() -> [NoteItem] {
        guard let list = pasteboard.string?.split(separator: ":wq\n") else {
            return []
        }
        print(list)
        var notes: [NoteItem] = []
        for item in list {
            guard let note = noteBuild(string: String(item)) else {
                continue
            }
            notes.append(note)
        }
        return notes
    }
    // format eg: "- 🥗\n- 🍱\n- 🐣\n- 🌕\n- 🌞\n- 🍂\n- 🎡\n"
    func importTasksfromPasteboard() -> [TaskItem] {
        guard let list = pasteboard.string?.split(separator: "\n") else {
            return []
        }
        var tasks: [TaskItem] = []
        for item in list {
            guard let task = taskBuild(string: String(item)) else {
                continue
            }
            tasks.append(task)
        }
        return tasks
    }
    
    private func noteBuild(string: String) -> NoteItem? {
        guard (string.firstIndex(of: "#") == String.Index(encodedOffset: 0)) else {
            return nil
        }
        let list = string.split(separator: "\n", maxSplits: 1)
        var title = list.first!.suffix(from: String.Index(encodedOffset: 2))
        var content = list.last!
        let note = NoteItem(title: String(title), content: String(content))
        return note
    }
    
    private func taskBuild(string: String) -> TaskItem? {
        guard (string.firstIndex(of: "-") == String.Index(encodedOffset: 0)) else {
            return nil
        }
        let task = TaskItem(title: String(string.suffix(from: String.Index(encodedOffset: 2))))
        return task
    }
    
    func test() {
        print(pasteboard.string?.split(separator: "\n") ?? "")
    }
    
}
