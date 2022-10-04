//
//  NoteDetailView.swift
//  NotePad
//
//  Created by rockey220505 on 2022/10/4.
//

import SwiftUI

struct NoteDetailView: View {
    @Binding var note: NoteItem
    
    var body: some View {
        VStack {
            TextField($note.content, placeholder: Text("Start typing here"))
                .padding(.init(top: 20, leading: 20, bottom: 200, trailing: 20))
                .background(Color.blue)
            Spacer()
        }.navigationBarTitle(Text(note.title))
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView()
    }
}
