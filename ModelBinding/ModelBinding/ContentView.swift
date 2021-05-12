//
//  ContentView.swift
//  ModelBinding
//
//  Created by 詹昆宬 on 2021/5/10.
//

import SwiftUI

struct ContentView: View {
    @State private var stars: CGFloat = 0
    @State private var isFollowing: Bool = false
    @State private var episode: Int = 0
    @State private var evaluate = ""
    @State private var lastViewTime = Date()
    @State private var showAlert = false
    var actors = ["薇薇", "松本"]
    @State private var selectedActorName = ""

    
    var body: some View {
        VStack {
            Text("VIVY")
                .font(.system(size: 30))
                .padding()
            Image("vivy")
                .resizable()
                .frame(width: 250, height: 300)
                .clipShape(Circle())
            
            Toggle(isOn: $isFollowing) {
                Text("有追嗎？")
            }
            Stepper("集數: \(episode)", value: $episode, in: 0...7, step: 1)
            
            DatePicker("最後觀看日期：", selection: $lastViewTime, displayedComponents: .date)
            
            HStack {
                Text("評分：")
                Slider(value: $stars, in: 0...5)
                    .accentColor(.orange)
                Text("\(Int(stars))星")
            }
            
            Picker(selection: $selectedActorName, label: Text("喜歡的角色")) {
                ForEach(actors, id: \.self) { (actor) in
                    Text(actor)
                }
            }
            
            TextField("評價", text: $evaluate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                showAlert = true
            }, label: {
                Text("送出")
            })
            
        }
        .padding()
        .alert(isPresented: $showAlert, content: {
            if(isFollowing) {
                return Alert(title: Text("我有追\n目前看到第\(episode)集\n\n最後一次看是\(lastViewTime)\n\n我的評分是\(Int(stars))顆星\n我最喜歡的角色是\(selectedActorName)\n我想說：\(evaluate)"))
            } else {
                return Alert(title: Text("我沒追"))
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
