//
//  ContentView.swift
//  ToDoApp
//
//  Created by 詹昆宬 on 2021/5/30.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var repo = TaskRepository()
    @State private var name: String = ""
    @State private var deadline: Date = Date()
    @State private var isDone: String = ""
    
    var body: some View {
        VStack {
            
            Text("ToDO App")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 40))
        
            Spacer()
            
            Group {
                Text("輸入數據")
                
                HStack {
                    Text("名稱：")
                        .font(.system(size: 20))
                    TextField("", text: $name)
                        .font(.system(size: 20))
                }
                
                HStack {
                    Text("是否完成：")
                        .font(.system(size: 20))
                    TextField("", text: $isDone)
                        .font(.system(size: 20))
                }
                
                HStack {
                    DatePicker("到期時間", selection: $deadline, in: ...Date())
                }
                
                HStack {
                    Button(action: {
                        let task = Task(name: name, deadline: deadline, isDone: isDone)
                        repo.save(task: task)
                    }) {
                      Text("新增數據")
                    }
                }
            }
            
            Spacer()
            Divider()
            Spacer()
            
            Group {
                Text("目前數據")
                
                VStack {
                    ForEach(repo.tasks) { task in
                        Text("名稱：\(task.name)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 20))
                        Text("是否完成：\(task.isDone)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 20))
                        Text("到期時間：\(task.deadline)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 20))
                        Spacer()
                    }
                }
                
                HStack {
                    Button(action: {
                        repo.get()
                    }) {
                      Text("讀取數據")
                    }
                }
            }
            
            
            Spacer()
            
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
