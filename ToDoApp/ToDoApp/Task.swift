//
//  Task.swift
//  ToDoApp
//
//  Created by 詹昆宬 on 2021/5/31.
//

import Foundation
import FirebaseFirestoreSwift

class Task: Codable, Identifiable {
    internal init(name: String, deadline: Date, isDone: String) {
        self.name = name
        self.deadline = deadline
        self.isDone = isDone
    }
    
    @DocumentID var id: String?
    let name: String
    let deadline: Date
    let isDone: String
}
