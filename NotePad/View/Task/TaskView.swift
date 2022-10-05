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
    @State var taskToDo: TaskItem?
    @State var taskItems: [TaskItem] = {
        guard let data = UserDefaults.standard.data(forKey: "tasks") else { return [] }
        if let json = try? JSONDecoder().decode([TaskItem].self, from: data) {
            return json
        }
        return []
    }()
    @State var taskCompletedItems: [TaskItem] = {
        guard let data = UserDefaults.standard.data(forKey: "tasks_done") else { return [] }
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
                    Section(header: Text("ToDo(\(taskItems.count))").font(.subheadline)) {
                        ForEach(taskItems, id: \.self) { item in
                            HStack {
                                Button(action: {
                                    taskToComplete = item
                                    completeTask()
                                }, label: {
                                    Image(systemName: "square")
                                }).buttonStyle(BorderlessButtonStyle())
                                TaskItemView(item: item)
                            }
                            
                        }.onDelete(perform: deleteTask)
                         .onMove(perform: moveTask)
                         .onLongPressGesture {
                            withAnimation {
                                self.isEditable = true
                            }
                         }
                    }
                    Section(header: Text("Completed(\(taskCompletedItems.count))").font(.subheadline)) {
                        ForEach(taskCompletedItems, id: \.self) { item in
                            HStack {
                                Button(action: {
                                    taskToDo = item
                                    makeTaskToDo()
                                }, label: {
                                    Image(systemName: "checkmark.square.fill")
                                }).buttonStyle(BorderlessButtonStyle())
                                TaskItemView(item: item)
                            }
                        }.onDelete(perform: deleteTask)
                         .onMove(perform: moveTask)
                         .onLongPressGesture {
                            withAnimation {
                                self.isEditable = true
                            }
                         }
                    }
                }.toolbar{ EditButton() }
                 .navigationTitle("ToDoList")
//                .environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
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
        taskCompletedItems.insert(TaskItem(id: id, title: "TaskTitle", content: "TaskText\(id)",isComleted: true), at: 0)
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
        guard var taskToComplete = taskToComplete else {
            return
        }
        taskItems = taskItems.filter { $0 != taskToComplete }
        taskToComplete.isComleted.toggle()
        taskCompletedItems.append(taskToComplete)
        saveTasks()
    }
    
    func makeTaskToDo() {
        guard var taskToDo = taskToDo else {
            return
        }
        taskCompletedItems = taskCompletedItems.filter { $0 != taskToDo }
        taskToDo.isComleted.toggle()
        taskItems.append(taskToDo)
        saveTasks()
    }
    
    func saveTasks() {
        guard let data = try? JSONEncoder().encode(taskItems) else { return }
        UserDefaults.standard.set(data, forKey: "tasks")
        guard let data1 = try? JSONEncoder().encode(taskCompletedItems) else { return }
        UserDefaults.standard.set(data1, forKey: "tasks_done")
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
