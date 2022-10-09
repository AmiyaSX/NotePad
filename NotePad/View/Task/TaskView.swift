//
//  TasksView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct TaskView: View {
    @State var searchQuery = ""
    @EnvironmentObject private var taskViewModel: TaskViewModel
    @EnvironmentObject private var loginViewModel: LoginViewModel
    @Environment(\.editMode) private var editMode
    @State private var isPresented = false
    let pc = PasteboardControler()
    
    private var TrailingMenu: some View {
        return HStack {
            if (editMode?.wrappedValue == .active) {
                Button(action: taskViewModel.deleteSelectTasks, label: {
                    Image(systemName: "trash")
                })
                Button(action: taskViewModel.pinTasks, label: {
                    Image(systemName: "pin")
                })
            }
            EditButton()
            if (editMode?.wrappedValue == .inactive) {
                Menu {
                    Button("Import from Pasteboard", action: {
                        taskViewModel.taskItems += pc.importTasksfromPasteboard()
                    })
                    Button("Save to iCloud", action: {
                        
                    })
                    Button("Logout", action: {
                        loginViewModel.needLogin = true
                    })
                } label: {
                    Label("Menu", systemImage: "ellipsis")
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List(selection: $taskViewModel.selectTasks) {
                    Section(header: Text("Todo(\(taskViewModel.taskItems.count))").font(.subheadline)) {
                        ForEach(taskViewModel.taskItems, id: \.self) { item in
                            if (searchQuery == "" || item.title.localizedCaseInsensitiveContains(searchQuery)) {
                                ZStack {
                                    NavigationLink(destination:  TaskDetailView(task: $taskViewModel.taskItems[taskViewModel.findItemIdex(item: item)], title: taskViewModel.taskItems[taskViewModel.findItemIdex(item: item)].title)) {
                                    }.opacity(0)
                                    HStack(alignment: .firstTextBaseline) {
                                        if (editMode?.wrappedValue == .inactive) {
                                            Button(action: {
                                                taskViewModel.taskToComplete = item
                                                taskViewModel.completeTask()
                                            }, label: {
                                                Image(systemName: "square")
                                                    .foregroundColor(item.isPin ? Color.blue : Color.black)
                                            }).buttonStyle(BorderlessButtonStyle())
                                        }
                                        TaskItemView(item: item)
                                    }.padding(.init(top: 12, leading: 0, bottom: 0, trailing: 0))
                                }.listRowBackground(item.isPin ? Color(UIColor(named: "TaskPinColor" )!) : Color.white)
                            }
                        }.onDelete(perform: taskViewModel.deleteTask)
                        .onMove(perform: taskViewModel.moveTask)
                        .deleteDisabled(true)
                        .onLongPressGesture {
                            withAnimation {
                                taskViewModel.isEditable = true
                            }
                         }.buttonStyle(PlainButtonStyle())
                            
                    }
                    Section(header: Text("Completed(\(taskViewModel.taskCompletedItems.count))").font(.subheadline)) {
                        ForEach(taskViewModel.taskCompletedItems, id: \.self) { item in
                            if (searchQuery == "" || item.title.localizedCaseInsensitiveContains(searchQuery)) {
                                ZStack {
                                    NavigationLink(destination:  TaskDetailView(task: $taskViewModel.taskCompletedItems[taskViewModel.findCompletedItemIdex(item: item)], title: taskViewModel.taskCompletedItems[taskViewModel.findCompletedItemIdex(item: item)].title)) {
                                    }.opacity(0)
                                    HStack(alignment: .firstTextBaseline) {
                                        if (editMode?.wrappedValue == .inactive) {
                                            Button(action: {
                                                taskViewModel.taskToDo = item
                                                taskViewModel.makeTaskToDo()
                                            }, label: {
                                                Image(systemName: "checkmark.square.fill")
                                                    .foregroundColor(Color.gray)
                                            }).buttonStyle(BorderlessButtonStyle())
                                        }
                                        TaskItemView(item: item)
                                    }.padding(.init(top: 12, leading: 0, bottom: 0, trailing: 0))
                                }.listRowBackground(Color.white)
                            }
                        }.onDelete(perform: taskViewModel.deleteCompletedTask)
                            .onMove(perform: taskViewModel.moveCompletedTask)
                            .deleteDisabled(true)
                         .onLongPressGesture {
                            withAnimation {
                                taskViewModel.isEditable = true
                            }
                         }.buttonStyle(PlainButtonStyle())
                    }
                }
                Button(action: {
                    isPresented.toggle()
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50, alignment:.center)
                        .background(Color.green)
                        .clipShape(Circle())
                        .shadow(color: .primary, radius: 60, x: 0.1, y: 0.1)
                }.padding(12)
                .sheet(isPresented: $isPresented) {
                    TaskCreateView(task: $taskViewModel.newTask, title: taskViewModel.newTask.title)
                        .presentationDetents([.height(250)])
                }
            }.navigationBarItems(leading: UserView().frame(maxWidth: .infinity, alignment: .leading), trailing: TrailingMenu)
            .environment(\.editMode, editMode)
            .navigationTitle("ToDoList")
            .onChange(of: taskViewModel.taskItems, perform: { _ in
                taskViewModel.saveTasks()
            })
            .onChange(of: taskViewModel.taskCompletedItems, perform: { _ in
                taskViewModel.saveTasks()
            })
        }.searchable(text: $searchQuery, prompt: "Search By Keywords")
    }
}
