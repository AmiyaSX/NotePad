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
    @Published var needLogin: Bool = false
    @Published var needRegister: Bool = false
    @Published var userAccount: String = ""
    static let shared = LoginViewModel()
    
    init() {
        
    }
    
    func login() -> Bool {
        guard let pwd = UserDefaults.standard.string(forKey: account) else {
            return false
        }
        if pwd != "" && pwd == password {
            needLogin = false
            needRegister = false
            userAccount = account
            UserDefaults.standard.set(account, forKey: "identify")
            clear()
            return true
        }
        return false
    }
    
    func register() -> Bool {
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
    
    func checkLocalAccount() {
        guard let account = UserDefaults.standard.string(forKey: "identify") else {
            needLogin = true
            return
        }
        userAccount = account
        let pwd = UserDefaults.standard.string(forKey: account)
        if (pwd != "") {
            self.account = account
            needRegister = false
            needLogin = false
        } else {
            needLogin = true
        }
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
