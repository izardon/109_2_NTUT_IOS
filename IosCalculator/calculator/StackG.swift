//
//  StackG.swift
//  calculator
//
//  Created by 詹昆宬 on 2021/5/1.
//

import Foundation

struct StackG<Element> {
    private var items = [Element]()
    mutating func push(item:Element) {
        items.append(item)
    }
    mutating func pop() ->Element? {
        return items.removeLast()
    }
    func empty() -> Bool {
        return items.isEmpty
    }
    func peek() ->Element? {
        return items.last
    }
    func count() -> Int! {
        return items.count
    }
}
