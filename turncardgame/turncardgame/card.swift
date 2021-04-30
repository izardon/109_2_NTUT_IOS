//
//  Card.swift
//  turncardgame
//
//  Created by 詹昆宬 on 2021/3/17.
//

import Foundation

struct Card : Hashable{
    
    var isFaceUp = false
    var isMatched = false
    private var identifier:Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier()->Int{
        identifierFactory+=1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
