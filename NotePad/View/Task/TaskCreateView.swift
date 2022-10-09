//
//  TaskCreateView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/6.
//

import SwiftUI

struct TaskCreateView: View {
    @Binding var task: TaskItem
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var title: String
    
    var body: some View {
        ZStack {
            VStack {
                Text(task.dateText).font(.footnote).frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.init(top: 20, leading: 20, bottom: 20, trailing: 20))
                VStack {
                    TextField("NoteTitle", text: $title, prompt: Text("Title"))
                        .font(.title3)
                        .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        .background(Color(UIColor(named: "TextFieldColor")!))
                        .padding(.horizontal)
                }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                .background(Color(UIColor(named: "TextFieldColor")!))
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
                            .padding(.init(top: 60, leading: 20, bottom: 0, trailing: 20))
                    })
                    Spacer()
                    Button(action: {
                        saveTask()
                        presentationMode.wrappedValue.dismiss() //解决子视图返回根视图问题
                    }, label: {
                        Text("Save")
                            .foregroundColor(Color.white)
                            .frame(width: 150, height: 40, alignment: .center)
                            .background(Color.green)
                            .cornerRadius(20)
                            .padding(.init(top: 60, leading: 20, bottom: 0, trailing: 20))
                    })
                }
                
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
    func saveTask() {
        task.title = title
        task.date = Date()
        taskViewModel.addTask()
    }
}
