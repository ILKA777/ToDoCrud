//
//  PriorityView.swift
//  ToDoCRUD
//
//  Created by Илья on 04.02.2024.
//

import SwiftUI

struct PriorityButtonsView: View {
    let priorityTitle: String
    @Binding var selectedPriority: Priority
    
    var body: some View {
        Text(priorityTitle)
            .font(.system(.headline, design: .rounded))
            .foregroundColor(.white)
            .padding(10)
            .background(selectedPriority.priorityType == priorityTitle.lowercased() ? selectedPriority.priorityColor() : Color(.systemGray4))
            .cornerRadius(10)
    }
}

struct PriorityView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            PriorityButtonsView(priorityTitle: "Высокий", selectedPriority: .constant(.high))
            PriorityButtonsView(priorityTitle: "Средний", selectedPriority: .constant(.normal))
            PriorityButtonsView(priorityTitle: "Низкий", selectedPriority: .constant(.low))
        }
    }
}
