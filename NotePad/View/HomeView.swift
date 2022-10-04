//
//  HomeView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct HomeView: View {

    var SearchBar: some View {
        return HStack {
            
        }
    }

    var body: some View {
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
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
