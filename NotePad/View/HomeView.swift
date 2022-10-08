//
//  HomeView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct HomeView: View {
    @StateObject var noteViewModel = NoteViewModel.shared
    @StateObject var taskViewModel = TaskViewModel.shared
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var SearchBar: some View {
        return HStack(spacing: 6) {
            Image(systemName: "magnifyingglass").font(.title3).foregroundColor(.gray)
            TextField("Search", text: .constant(""))
        }.frame(alignment: .leading)
    }

    var body: some View {
        VStack {
            TabView {
                NoteView().tabItem {
                    NavigationLink(destination: NoteView()) {
                            Image(systemName: "doc.text")
                            Text("Note")
                        }.tag(1)
                }
                TaskView().tabItem {
                    NavigationLink(destination: TaskView()) {
                            Image(systemName: "square.and.pencil")
                            Text("Todo")
                        }.tag(2)
                }
            }
        }.environmentObject(noteViewModel)
        .environmentObject(taskViewModel)
        .onChange(of: loginViewModel.userAccount, perform: { _ in
             noteViewModel.dataUpdate()
             taskViewModel.dataUpdate()
         })
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
