//
//  GameViewModel.swift
//  FingerGuessingGame
//
//  Created by 詹昆宬 on 2021/5/19.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var playerFigure: Figure?
    @Published var computerFigure: Figure?
    @Published var result: GameResult?
    
    var figures: [Figure] = {
        var figures = [Figure]()
        for shape in Figure.Shape.allCases {
            let figure = Figure(shape: shape)
            figures.append(figure)
        }
        return figures
    }()
    
    func play() {
        figures.shuffle()
        computerFigure = figures[0]
        figures.shuffle()
        playerFigure = figures[0]
        result = checkResult()
    }
    
    func checkResult() -> GameResult {
        if (playerFigure?.shape.text == "剪刀") {
            if(computerFigure?.shape.text == "石頭") {
                return .lose
            } else if ((computerFigure?.shape.text == "布")) {
                return .win
            }
        }
        else if (playerFigure?.shape.text == "石頭") {
            if(computerFigure?.shape.text == "剪刀") {
                return .win
            } else if ((computerFigure?.shape.text == "布")) {
                return .lose
            }
        }
        else if (playerFigure?.shape.text == "布") {
            if(computerFigure?.shape.text == "剪刀") {
                return .lose
            } else if ((computerFigure?.shape.text == "石頭")) {
                return .win
            }
        }
        return .tie
    }
}
