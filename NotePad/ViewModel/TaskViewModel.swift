//
//  TaskViewController.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/5.
//

import Foundation
import Combine
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var taskToComplete: TaskItem?
    @Published var taskToDo: TaskItem?
    @State var isEditable = false
    @Published var tasksToDelete: [TaskItem]?
    @Published var taskItems: [TaskItem] = {
        guard let data = UserDefaults.standard.data(forKey: "tasks") else { return [] }
        if let json = try? JSONDecoder().decode([TaskItem].self, from: data) {
            return json
        }
        return []
    }()
    @Published var taskCompletedItems: [TaskItem] = {
        guard let data = UserDefaults.standard.data(forKey: "tasks_done") else { return [] }
        if let json = try? JSONDecoder().decode([TaskItem].self, from: data) {
            return json
        }
        return []
    }()
    
    static let shared = TaskViewModel()
    
    private init() { }
    
    
    func didTapAddTask() {
        let id = taskItems.reduce(0) { max($0, $1.id) } + 1
        taskItems.insert(TaskItem(id: id, title: "TaskTitle", content: "TaskText\(id)"), at: 0)
    }
    
    func deleteTask(at offsets: IndexSet) {
        taskItems.remove(atOffsets: offsets)
    }
    
    func deleteCompletedTask(at offsets: IndexSet) {
        taskCompletedItems.remove(atOffsets: offsets)
    }
    
    func deleteTasks() {
          guard let tasksToDelete = tasksToDelete else { return }
          taskItems = taskItems.filter { !tasksToDelete.contains($0) }
    }
    
    func deleteCompletedTasks(at offsets: IndexSet) {
        guard let tasksToDelete = tasksToDelete else { return }
        taskCompletedItems = taskCompletedItems.filter { !tasksToDelete.contains($0) }
    }
    
    func moveTask(from source: IndexSet, to destination: Int) {
        taskItems.move(fromOffsets: source, toOffset: destination)
        withAnimation {
            isEditable = false
        }
    }
    
    func completeTask() {
        guard var taskToComplete = taskToComplete else {
            return
        }
        taskItems = taskItems.filter { $0 != taskToComplete }
        taskToComplete.isComleted.toggle()
        taskCompletedItems.append(taskToComplete)
    }
    
    func makeTaskToDo() {
        guard var taskToDo = taskToDo else {
            return
        }
        taskCompletedItems = taskCompletedItems.filter { $0 != taskToDo }
        taskToDo.isComleted.toggle()
        taskItems.append(taskToDo)
    }
    
    func saveTasks() {
        guard let data = try? JSONEncoder().encode(taskItems) else { return }
        UserDefaults.standard.set(data, forKey: "tasks")
        guard let data1 = try? JSONEncoder().encode(taskCompletedItems) else { return }
        UserDefaults.standard.set(data1, forKey: "tasks_done")
    }
    
}
