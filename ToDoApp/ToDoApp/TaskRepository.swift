//
//  TaskRepository.swift
//  ToDoApp
//
//  Created by 詹昆宬 on 2021/5/31.
//

import Foundation
import Firebase

class TaskRepository: ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        get()
    }
    
    func save(task: Task) {
        let db = Firestore.firestore()
        do {
            let documentReference = try
                db.collection("tasks").addDocument(from: task)
            print(documentReference.documentID)
        } catch {
            print(error)
        }
    }

    func get() {
        let db = Firestore.firestore()
        db.collection("tasks").order(by: "deadline", descending: true).limit(to: 3).getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            self.tasks = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: Task.self)
            }
            
            print(self.tasks)
        }
    }
}
