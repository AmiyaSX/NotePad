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
    @State private var isEditable = false
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
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(taskItems, id: \.self) { item in
                        TaskItemView(item: item)
                    }.onDelete(perform: deleteTask)
                     .onMove(perform: moveTask)
                     .onLongPressGesture {
                        withAnimation {
                            self.isEditable = true
                        }
                     }
                }.environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
                Button(action: didTapAddTask, label: {
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
    
    func didTapAddTask() {
        let id = taskItems.reduce(0) { max($0, $1.id) } + 1
        taskItems.insert(TaskItem(id: id, title: "TaskTitle", content: "TaskText\(id)"), at: 0)
        saveTasks()
    }
    
    func moveTask(from source: IndexSet, to destination: Int) {
        taskItems.move(fromOffsets: source, toOffset: destination)
        withAnimation {
            isEditable = false
        }
        saveTasks()
    }
    
    func deleteTask(at offsets: IndexSet) {
        taskItems.remove(atOffsets: offsets)
        saveTasks()
    }
    
    func deleteTasks() {
          guard let tasksToDelete = tasksToDelete else { return }
          taskItems = taskItems.filter { !tasksToDelete.contains($0) }
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
