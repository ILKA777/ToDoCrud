//
//  NewTaskView.swift
//  ToDoCRUD
//
//  Created by Илья on 04.02.2024.
//

import SwiftUI

struct NewTaskView: View {
    @Binding var isShow: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @State private var keyboardHeight: CGFloat = 0
    
    @State private var taskName: String = ""
    @State private var taskPriority: Priority = .normal
    @State private var isEditing: Bool = false
    @State private var isDatePickerVisible: Bool = false
    @State private var dueDate: Date = Date()
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Добавить задачу")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        self.isShow = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(self.taskPriority.priorityColor())
                    }
                }
                
                TextField("Описание задачи", text: self.$taskName, onEditingChanged: { editing in
                    withAnimation {
                        self.isEditing = editing
                        self.isDatePickerVisible = !editing // Disable DatePicker when editing
                    }
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom)
                
                Text("Priority")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                HStack {
                    PriorityButtonsView(priorityTitle: "Высокий", selectedPriority: self.$taskPriority)
                        .onTapGesture { self.taskPriority = .high }
                    
                    PriorityButtonsView(priorityTitle: "Средний", selectedPriority: self.$taskPriority)
                        .onTapGesture { self.taskPriority = .normal }
                    
                    PriorityButtonsView(priorityTitle: "Низкий", selectedPriority: self.$taskPriority)
                        .onTapGesture { self.taskPriority = .low }
                }
                
                Button(action: {
                    withAnimation {
                        self.isDatePickerVisible.toggle()
                    }
                }) {
                    Text("Дата и время")
                        .foregroundColor(.green)
                    
                }
                .disabled(self.keyboardHeight > 0)
                .offset(x: 5, y: 10)
                
                if isDatePickerVisible {
                    DatePicker("Дата и время", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .offset(x: 5, y: 10)
                }
                
                Button(action: {
                    guard self.taskName.trimmingCharacters(in: .whitespaces) != "" else { return }
                    
                    self.isShow = false
                    self.addNewTask(name: self.taskName, priority: self.taskPriority, dueDate: self.dueDate)
                }) {
                    Text("Добавить задачу")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(self.taskPriority.priorityColor())
                }
                .cornerRadius(10)
                .padding(.vertical)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
            .offset(y: self.isEditing ? -320 : 0)
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = keyboardSize.height
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.keyboardHeight = 0
            }
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        )
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func addNewTask(name: String, priority: Priority, dueDate: Date) -> Void {
        let newTask = Task(context: viewContext)
        newTask.id = UUID()
        newTask.name = name
        newTask.priority = priority
        newTask.complete = false
        newTask.dueDate = dueDate
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(isShow: .constant(true))
    }
}
