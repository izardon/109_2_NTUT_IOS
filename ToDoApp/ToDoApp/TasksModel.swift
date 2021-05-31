//
//  TasksModel.swift
//  ToDoApp
//
//  Created by 詹昆宬 on 2021/5/31.
//

import Foundation

class TasksModel: ObservableObject {
    @Published var tasks: [Task]
    
    init() {
        self.tasks = [

        ]
    }
}
