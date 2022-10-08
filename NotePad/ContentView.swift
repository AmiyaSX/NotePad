//
//  ContentView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginViewModel = LoginViewModel.shared
    
    var body: some View {
        HomeView()
            .fullScreenCover(isPresented: $loginViewModel.needRegister, content: {
                RegisterView()
            })
            .fullScreenCover(isPresented: $loginViewModel.needLogin, content: {
                LoginView()
            })
            .environmentObject(loginViewModel)
            .onAppear() {
                loginViewModel.checkLocalAccount()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
