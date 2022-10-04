//
//  TasksView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct TaskView: View {
    @State var tasksToDelete: [TaskItem]?
    @State var showAlert = false
    @State var taskToComplete: TaskItem?
    @State var taskItems: [TaskItem] = {
        guard let data = UserDefaults.standard.data(forKey: "tasks") else { return [] }
        if let json = try? JSONDecoder().decode([TaskItem].self, from: data) {
            return json
        }
        return []
    }()
    var alert: Alert {
           Alert(title: Text("Hey!"),
                 message: Text("Are you sure you want to delete?"),
                 primaryButton: .destructive(Text("Delete"), action: deleteTasks),
                 secondaryButton: .cancel())
    }
    
    var body: some View {
        NavigationView {
            List(taskItems) { item in
                VStack(alignment: .leading) {
                    Text(item.dateText).font(.headline)
                    Text(item.content).lineLimit(nil).multilineTextAlignment(.leading)
                }.onLongPressGesture {
                        self.tasksToDelete = [item]
                        self.showAlert = true
                    }
                }.alert(isPresented: $showAlert, content: {
                            alert
                })
            Button(action: didTapAddTask, label: { Text("Add") }).padding(8)
        }
    }
    
    func didTapAddTask() {
        let id = taskItems.reduce(0) { max($0, $1.id) } + 1
        taskItems.insert(TaskItem(id: id, title: "TaskTitle", content: "TaskText"), at: 0)
        saveTasks()
    }
    
    func deleteTasks() {
          guard let itemToDelete = tasksToDelete else { return }
          taskItems = itemToDelete.filter { !$0.isToDelete }
          saveTasks()
    }
    
    func completeTask() {
        guard let taskToComplete = taskToComplete else {
            return
        }
        saveTasks()
    }
    
    func saveTasks() {
        guard let data = try? JSONEncoder().encode(taskItems) else { return }
        UserDefaults.standard.set(data, forKey: "tasks")
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
