//
//  TasksView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct TaskView: View {

    @EnvironmentObject private var taskViewModel: TaskViewModel
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List {
                    Section(header: Text("Todo(\(taskViewModel.taskItems.count))").font(.subheadline)) {
                        ForEach(taskViewModel.taskItems, id: \.self) { item in
                            ZStack {
                                NavigationLink(destination:  TaskDetailView(task: $taskViewModel.taskItems[taskViewModel.findItemIdex(item: item)], title: taskViewModel.taskItems[taskViewModel.findItemIdex(item: item)].title)) {
                                }.opacity(0)
                                HStack(alignment: .firstTextBaseline) {
                                    Button(action: {
                                        taskViewModel.taskToComplete = item
                                        taskViewModel.completeTask()
                                    }, label: {
                                        Image(systemName: "square")
                                            .foregroundColor(Color.green)
                                    }).buttonStyle(BorderlessButtonStyle())
                                    TaskItemView(item: item)
                                }
                            }
                        }.onDelete(perform: taskViewModel.deleteTask)
                            .onMove(perform: taskViewModel.moveTask)
                         .onLongPressGesture {
                            withAnimation {
                                taskViewModel.isEditable = true
                            }
                         }
                    }
                    Section(header: Text("Completed(\(taskViewModel.taskCompletedItems.count))").font(.subheadline)) {
                        ForEach(taskViewModel.taskCompletedItems, id: \.self) { item in
                            HStack(alignment: .firstTextBaseline) {
                                Button(action: {
                                    taskViewModel.taskToDo = item
                                    taskViewModel.makeTaskToDo()
                                }, label: {
                                    Image(systemName: "checkmark.square.fill")
                                        .foregroundColor(Color.gray)
                                }).buttonStyle(BorderlessButtonStyle())
                                TaskItemView(item: item)
                            }
                        }.onDelete(perform: taskViewModel.deleteCompletedTask)
                            .onMove(perform: taskViewModel.moveTask)
                         .onLongPressGesture {
                            withAnimation {
                                taskViewModel.isEditable = true
                            }
                         }
                    }
                }
                Button(action: {
                    isPresented.toggle()
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50, alignment:.center)
                        .background(Color.yellow)
                        .clipShape(Circle())
                        .shadow(color: .primary, radius: 60, x: 0.1, y: 0.1)
                }.padding(12)
                .sheet(isPresented: $isPresented) {
                    TaskCreateView(task: $taskViewModel.newTask, title: taskViewModel.newTask.title)
                        .presentationDetents([.height(250)])
                }

                    
                
            }.toolbar{ EditButton() }
            .navigationTitle("ToDoList")
            .onChange(of: taskViewModel.taskItems, perform: { _ in
                taskViewModel.saveTasks()
            })
            .onChange(of: taskViewModel.taskCompletedItems, perform: { _ in
                taskViewModel.saveTasks()
            })
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
