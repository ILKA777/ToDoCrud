//
//  Task.swift
//  ToDoCRUD
//
//  Created by Илья on 04.02.2024.
//

import SwiftUI
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var complete: Bool
    @NSManaged public var priorityNum: Int32
    @NSManaged public var dueDate: Date?
}

extension Task: Identifiable {
    var priority: Priority {
        get {
            Priority(rawValue: Int(priorityNum)) ?? .normal
        }
        
        set {
            self.priorityNum = Int32(newValue.rawValue)
        }
    }
}

enum Priority: Int {
    case low = 0
    case normal = 1
    case high = 2
    
    var priorityType: String {
        switch rawValue {
            case Priority.low.rawValue: return "низкий"
            case Priority.normal.rawValue: return "средний"
            case Priority.high.rawValue: return "высокий"
            
            default: return ""
        }
    }

    func priorityColor() -> Color {
        switch rawValue {
            case Priority.low.rawValue: return .green
            case Priority.normal.rawValue: return .yellow
            case Priority.high.rawValue: return .red
            
            default: return .orange
        }
    }
}
