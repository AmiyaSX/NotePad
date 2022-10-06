//
//  TaskItemView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct TaskItemView: View {
    var item: TaskItem
    
    var body: some View {
        VStack(alignment: .leading) {
            if (item.isComleted) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(Color.gray)
                    .strikethrough()
                    .padding(.top)
                    
            } else {
                Text(item.title)
                    .font(.headline)
                    .padding(.top)
            }
                    
            Spacer()
            Text(item.dateText)
                .font(.caption2)
                .italic()
                .foregroundColor(item.isComleted ? Color.gray : Color.black)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
}
