//
//  LoginViewModel.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/7.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var account: String = ""
    @Published var password: String = ""
    @Published var verifyPassword: String = ""
    @Published var needLogin: Bool = true
    @Published var needRegister: Bool = false
    
    static let shared = LoginViewModel()
    
    func login() -> Bool {
        guard let pwd = UserDefaults.standard.string(forKey: account) else {
            return false
        }
        if pwd != "" && pwd == password {
            clear()
            needLogin = false
            needRegister = false
            UserDefaults.standard.set(account, forKey: "identify")
            return true
        }
        return false
    }
    
    func register() -> Bool {
        print(account)
        print(password)
        print(verifyPassword)
        let pwd = UserDefaults.standard.string(forKey: account)
        guard account != "" && pwd != "" && pwdCheck()else {
            return false
        }
        UserDefaults.standard.set(password, forKey: account)
        needRegister = false
        needLogin = true
        clear()
        return true
    }
    
    private func pwdCheck() -> Bool {
        return password != "" && password == verifyPassword
    }
    
    private func clear() {
        account = ""
        password = ""
        verifyPassword = ""
    }
}
