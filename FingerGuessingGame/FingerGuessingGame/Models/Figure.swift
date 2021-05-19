//
//  Figure.swift
//  FingerGuessingGame
//
//  Created by 詹昆宬 on 2021/5/19.
//

import Foundation

import UIKit.UIImage

struct Figure {
    let shape: Shape
    
    enum Shape: CaseIterable {
        case scissors
        case rock
        case paper
        
        var image: String {
            switch self {
                case .scissors: return "scissors"
                case .rock: return "rock"
                case .paper: return "paper"
            }
        }
        
        var text: String {
            switch self {
                case .scissors: return "剪刀"
                case .rock: return "石頭"
                case .paper: return "布"
            }
        }
    }
}
