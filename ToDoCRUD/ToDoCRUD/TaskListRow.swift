//
//  TaskListRow.swift
//  ToDoCRUD
//
//  Created by Илья on 04.02.2024.
//

import SwiftUI

struct TaskListRow: View {
    @ObservedObject var task: Task
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Toggle(isOn: self.$task.complete) {
                HStack {
                    Text(self.task.name)
                        .fontWeight(.bold)
                        .strikethrough(self.task.complete, color: self.task.priority.priorityColor())
                        .opacity(self.task.complete ? 0.5 : 1)
                    
                    Spacer()
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundColor(self.task.priority.priorityColor())
                }
            }
            .toggleStyle(CustomStyle(taskColor: self.task.priority.priorityColor()))
            
            if let dueDate = self.task.dueDate {
                Text("\(dueDate, style: .date) \(dueDate, style: .time)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .onReceive(self.task.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

struct TaskListRow_Previews: PreviewProvider {
    static var previews: some View {
        let testTask = Task(context: PersistenceController.preview.container.viewContext)
        testTask.id = UUID()
        testTask.name = "Test Task"
        testTask.complete = false
        testTask.priority = .normal
        testTask.dueDate = Date()
        
        return TaskListRow(task: testTask)
    }
}
