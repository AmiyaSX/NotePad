//
//  UserView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/8.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    var body: some View {
        HStack {
            Text(loginViewModel.userAccount.substring(to: String.Index(encodedOffset: 1)).uppercased())
                .foregroundColor(Color.white)
                .lineLimit(1)
                .frame(width: 40, height: 40, alignment: .center)
                .background(Color.blue)
                .cornerRadius(10)
            Spacer()
            Text(loginViewModel.userAccount)
                .font(.title3)
                .foregroundColor(Color.primary)
                .frame(width: 75)
        }
    }
}
