//
//  TaskDetailView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct TaskDetailView: View {
    @Binding var task: TaskItem
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var title: String
    
    var body: some View {
        ZStack {
            VStack {
                if (task.isComleted) {
                    Text("Completed Task").font(.title2)
                } else {
                    Text("TODO").font(.title2)
                }
                Text(task.dateText).font(.footnote).frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.init(top: 20, leading: 30, bottom: 20, trailing: 20))
                VStack {
                    TextField("NoteTitle", text: $title, prompt: Text("Title"))
                        .font(.title3)
                        .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        .background(task.isPin && !task.isComleted ? Color.white : Color(UIColor(named: "TextFieldColor")!))
                        .padding(.horizontal)
                }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    .background(task.isPin && !task.isComleted ? Color.white : Color(UIColor(named: "TextFieldColor")!))
                .cornerRadius(10)
                .padding(.horizontal)
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() //解决子视图返回根视图问题
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(Color.white)
                            .frame(width: 150, height: 40, alignment: .center)
                            .background(Color.gray)
                            .cornerRadius(20)
                            .padding(.init(top: 50, leading: 20, bottom: 20, trailing: 20))
                    })
                    Spacer()
                    Button(action: {
                        task.title = title
                        task.date = Date()
                        presentationMode.wrappedValue.dismiss() //解决子视图返回根视图问题
                    }, label: {
                        Text("Save")
                            .foregroundColor(Color.white)
                            .frame(width: 150, height: 40, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .padding(.init(top: 50, leading: 20, bottom: 20, trailing: 20))
                    })
                }
                
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(task.isPin && !task.isComleted ? Color(UIColor(named: "TaskPinColor" )!) : Color.white)
    }
}
