//
//  LoginView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/7.
//

import SwiftUI

struct LoginView: View {
    @State private var showPwd = false
    @State private var isPresented = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Text("Sign in")
                    .font(.title)
                    .bold()
                    .padding(.init(top: 20, leading: 20, bottom: 30, trailing: 20))
                HStack {
                    Image(systemName: "person").padding(.leading)
                    TextField("Please input your account", text: $loginViewModel.account)
                        .padding(14)
                }.background(Color(UIColor(named: "TextFieldColor")!))
                .cornerRadius(10)
                .padding(.init(top: 20, leading: 50, bottom: 10, trailing: 50))
                .frame(maxWidth: .infinity, alignment: .center)
                HStack {
                    Image(systemName: "lock").padding(.leading)
                    if showPwd {
                        TextField("Please input password", text: $loginViewModel.password).padding(14)
                    } else {
                        SecureField("Please input password", text: $loginViewModel.password).padding(14)
                    }
                }.background(Color(UIColor(named: "TextFieldColor")!))
                .cornerRadius(10)
                .padding(.init(top: 10, leading: 50, bottom: 0, trailing: 50))
                .frame(maxWidth: .infinity, alignment: .center)
                Button(action: {
                    if (loginViewModel.login()) {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        isPresented = true
                    }
                }, label: {
                    Text("LOGIN")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 290, height: 50, alignment: .center)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .padding(.init(top: 50, leading: 20, bottom: 0, trailing: 20))
                }).buttonStyle(.borderless)
                Spacer()
            }.frame(maxHeight: 580, alignment: .topLeading)
            .ignoresSafeArea()
            .background(Color.white)
            .cornerRadius(20)
            HStack {
                Text("Don't have an account?")
                Text("Sign up").foregroundColor(Color.red)
                    .onTapGesture {
                        loginViewModel.needLogin = false
                        loginViewModel.needRegister = true
                    }
            }.frame(maxWidth: .infinity, alignment: .center)
            .padding(.init(top: 50, leading: 20, bottom: 80, trailing: 20))

        }.alert(Text("Login Failed"), isPresented: $isPresented, actions: {}, message: { Text("Please Check Your Password")})
        .frame(maxHeight: .infinity,alignment: .bottomTrailing)
        .ignoresSafeArea()
        .background(Color.yellow)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
