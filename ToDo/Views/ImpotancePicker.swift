//
//  ImpotancePicker.swift
//  ToDo
//
//  Created by Христина Буянова on 29.06.2024.
//

import SwiftUI

struct ImportancePicker: View {
    @Binding var importance: TodoItem.Importance

    var body: some View {
        Picker("", selection: $importance) {
            Image(systemName: "arrow.down")
                .tag(TodoItem.Importance.unimportant)
            Text("нет")
                .tag(TodoItem.Importance.ordinary)
            Text("‼")
                .tag(TodoItem.Importance.important)
        }
        .pickerStyle(.segmented)
    }
}
