//
//  DateUtil.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import Foundation

extension Date {
    
    func formatted(_ format: String = "MMM d yyyy, h:mm a") -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = format
           return formatter.string(from: self)
       }
}
