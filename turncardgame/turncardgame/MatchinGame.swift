//
//  MatchinGame.swift
//  turncardgame
//
//  Created by 詹昆宬 on 2021/3/17.
//

import Foundation

class MatchingGame{
    
    var score:Int = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex:Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var cards = [Card] ()
    var preMatchedCount = 0
    
    func chooseCard(at index:Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 5
                } else {
                    score -= 1
                }
                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = nil
            }
            else if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex == index{
                cards[index].isFaceUp = false
//                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
//                for flipDownIndex in cards.indices{
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                score -= 1
            }
        }
    }
    
    func chooseAll(flag:Bool){
        for index in cards.indices{
            cards[index].isFaceUp = flag
        }
    }
    
    func clearAll(){
        cards.removeAll()
    }
    
    func isMatch() -> Bool{
        var matchedCount:Int = 0;
        
        for index in cards.indices{
            if(cards[index].isMatched) {
                matchedCount = matchedCount + 1
            }
        }
        
        if( matchedCount > preMatchedCount ) {
            preMatchedCount = matchedCount
            return true
        } else {
            return false
        }
    }
    
    init(numberOfPairsOfCards:Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
}
