//
//  ContentView.swift
//  DiceGame
//
//  Created by 詹昆宬 on 2021/4/28.
//

import SwiftUI

struct ContentView: View {
    @State private var diceNumber1 = 1
    @State private var diceNumber2 = 1
    @State private var diceNumber3 = 1
    @State private var predictionSum = ""
    @State private var predictionResult = "猜測中"
    @State private var currentMoney = 1000
    
    var body: some View {
        
        VStack (alignment: .leading) {
            Text("骰子遊戲")
                .padding()
                .font(.custom("FONT_NAME", size: 35))
                .frame(maxWidth: .infinity, alignment: .center)

            HStack {
                Image("dice_\(diceNumber1)")
                Text("骰子1數字： \(diceNumber1)")
            }
            HStack {
                Image("dice_\(diceNumber2)")
                Text("骰子2數字： \(diceNumber2)")
            }
            HStack {
                Image("dice_\(diceNumber3)")
                Text("骰子3數字： \(diceNumber3)")
            }
            HStack {
                TextField("請輸入猜測總和", text: $predictionSum)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {self.diceGameExecute()}) {
                    Text("猜測！")
                }
            }
            Text("猜測結果： \(predictionResult)")
                .padding()
            Text("目前金額： \(currentMoney)")
                .padding()
        }.frame(
            minWidth: 0,
            maxWidth: 300,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
    }
    
    func diceGameExecute() {
        diceNumber1 = Int.random(in: 1...6)
        diceNumber2 = Int.random(in: 1...6)
        diceNumber3 = Int.random(in: 1...6)
        
        let sum: Int! = diceNumber1 + diceNumber2 + diceNumber3
        let prediction: Int! = Int($predictionSum.wrappedValue)
        
        if(prediction == nil) {
            predictionResult = "猜測總和請輸入數字"
        } else if(prediction >= sum) {
            predictionResult = "猜測成功加100元"
            currentMoney += 100
        } else {
            predictionResult = "猜測失敗減100元"
            currentMoney -= 100
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
