//
//  RegisterView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/7.
//

import SwiftUI

struct RegisterView: View {
    @State private var showPwd = false
    @State private var isPresented = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Text("Sign up")
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
                .padding(.init(top: 10, leading: 50, bottom: 10, trailing: 50))
                .frame(maxWidth: .infinity, alignment: .center)
                HStack {
                    Image(systemName: "lock").padding(.leading)
                    if showPwd {
                        TextField("Please input password", text: $loginViewModel.verifyPassword).padding(14)
                    } else {
                        SecureField("Please input password", text: $loginViewModel.verifyPassword).padding(14)
                    }
                }.background(Color(UIColor(named: "TextFieldColor")!))
                .cornerRadius(10)
                .padding(.init(top: 10, leading: 50, bottom: 0, trailing: 50))
                .frame(maxWidth: .infinity, alignment: .center)
                Button(action: {
                    if (loginViewModel.register()) {
                        loginViewModel.needLogin = true
                        presentationMode.wrappedValue.dismiss()
                    } else {
                       isPresented = true
                    }
                }, label: {
                    Text("REGISTE")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 290, height: 50, alignment: .center)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .padding(.init(top: 50, leading: 20, bottom: 20, trailing: 20))
                }).buttonStyle(.borderless)
                Spacer()
            }.alert(Text("Registe Failed"), isPresented: $isPresented, actions: {}, message: { Text("Please Check Your Password")})
            .frame(maxHeight: 580, alignment: .topLeading)
            .ignoresSafeArea()
            .background(Color.white)
            .cornerRadius(20)
            HStack {
                Text("Already have an account?")
                Text("Sign in").foregroundColor(Color.red)
                    .onTapGesture {
                        loginViewModel.needLogin = true
                        loginViewModel.needRegister = false
                    }
            }.frame(maxWidth: .infinity, alignment: .center)
            .padding(.init(top: 50, leading: 20, bottom: 80, trailing: 20))
        }.frame(maxHeight: .infinity,alignment: .bottomTrailing)
            .ignoresSafeArea()
        .background(Color.yellow)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
