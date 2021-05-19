//
//  ContentView.swift
//  FingerGuessingGame
//
//  Created by 詹昆宬 on 2021/5/19.
//

import SwiftUI

struct GameView: View {
    @StateObject var gameViewModel = GameViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("猜拳遊戲")
                    .padding()
                    .font(.system(size: 30))
                    
            }.frame(
                maxWidth: .infinity,
                alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
            )
            
            Spacer()
            
            HStack {
                Text("玩家：")
                    .padding()
                    .font(.system(size: 20))
                Text(gameViewModel.playerFigure?.shape.text ?? "")
                Image(gameViewModel.playerFigure?.shape.image ?? "")
                    .resizable()
                    .frame(
                        width: 55.0,
                        height: 70.0)
            }.frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            
            HStack {
                Text("電腦：")
                    .padding()
                    .font(.system(size: 20))
                Text(gameViewModel.computerFigure?.shape.text ?? "")
                Image(gameViewModel.computerFigure?.shape.image ?? "")
                    .resizable()
                    .frame(
                        width: 55.0,
                        height: 70.0)
            }.frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            
            Spacer()
            
            HStack {
                Image("scissors")
                    .resizable()
                    .frame(
                        width: 80.0,
                        height: 100.0)
                Image("rock")
                    .resizable()
                    .frame(
                        width: 80.0,
                        height: 100.0)
                Image("paper")
                    .resizable()
                    .frame(
                        width: 80.0,
                        height: 100.0)
            }.frame(
                maxWidth: .infinity,
                alignment: .center
            )
            
            HStack {
                Button(action: {
                    gameViewModel.play()
                }, label: {
                    Text("出拳！")
                        .padding()
                        .font(.system(size: 20))
                })
                
            }.frame(
                maxWidth: .infinity,
                alignment: .center
            )
            
            Spacer()
            
            HStack {
                Text("結果：")
                    .padding()
                    .font(.system(size: 20))
                
                if let result = gameViewModel.result  {
                    if(result == .win) {
                        Text("玩家獲勝")
                            .font(.system(size: 30))
                            .foregroundColor(Color.red)
                    }
                    else if(result == .lose) {
                        Text("玩家慘敗")
                            .font(.system(size: 30))
                            .foregroundColor(Color.red)
                    }
                    else if(result == .tie){
                        Text("雙方平手")
                            .font(.system(size: 30))
                            .foregroundColor(Color.red)
                    }
                    
                } else {
                    Text("請按'出拳'開始猜拳")
                        .font(.system(size: 30))
                        .foregroundColor(Color.red)
                }
            }.frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
