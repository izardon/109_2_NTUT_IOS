//
//  Calculator.swift
//  calculator
//
//  Created by 詹昆宬 on 2021/4/30.
//

import Foundation

class Calculator {
    var calculationResult:Double! = 0
    var currentOperand:String! = "0"
    var currentOperator:String! = ""
    var history:[String]! = []
    var expression = StackG<String>()
    var preOperatorPriority:Int! = 0
    let operatorPriorityDict:[String: Int]! = [
        "×" : 2,
        "÷" : 2,
        "+" : 1,
        "-" : 1
    ]
    
    func processInputOperand(input:String) {
        updateHistory()
        processExpression()
        saveOperatorToExpression()
        
        if(currentOperand == "0") {
            currentOperand = input
        } else if (currentOperand.contains(".") && input == ".") {
            // do nothing
        }
        else {
            currentOperand = currentOperand + input
        }
    }
    
    func processExpression() {
        if(!expression.empty() && expression.count() >= 3) {
            if(isPreviousOperatorPriorityGreaterThenOrEqualCurrentOperatorPriority()) {
                executeCalculation()
                saveOperandToExpression()
            } 
        }
    }
    
    func saveOperatorToExpression() {
        if(currentOperator != "") {
            preOperatorPriority = operatorPriorityDict[currentOperator]
            expression.push(item: currentOperator)
            currentOperator = ""
        }
    }
    
    func processInputOperator(input: String) {
        updateHistory()
        saveOperandToExpression()
        
        currentOperator = input
        if(currentOperator == "=") {
            updateHistory()
            while(expression.count() > 1) {
                executeCalculation()
                expression.push(item: currentOperand)
            }
        }
    }
    
    func saveOperandToExpression() {
        if(currentOperand != "") {
            expression.push(item: currentOperand)
            currentOperand = ""
        }
    }
    
    func isPreviousOperatorPriorityGreaterThenOrEqualCurrentOperatorPriority() -> Bool {
        return preOperatorPriority >= (operatorPriorityDict[currentOperator]!)
    }
    
    func updateHistory() {
        if(currentOperand != "") {
            if(history.count > 0 && !isOperator(elem: history.last ?? "")) {
                history.removeLast()
            }
            history.append(currentOperand)
        }
        
        if(currentOperator != "") {
            history.append(currentOperator)
        }
    }
    
    func isOperator(elem: String) -> Bool {
        var isOperator = false
        operatorPriorityDict.keys.forEach { key in
            if(elem == key) {
                isOperator = true
            }
        }
        return isOperator
    }
    
    func executeCalculation() {
        let rightOperand:Double! = Double(expression.pop()!)
        let calOperator = expression.pop()!
        let leftOperand:Double! = Double(expression.pop()!)
        
        switch calOperator {
        case "+":
            add(a: leftOperand, b: rightOperand)
        case "-":
            subtract(a: leftOperand, b: rightOperand)
        case "×":
            multiply(a: leftOperand, b: rightOperand)
        case "÷":
            divide(a: leftOperand, b: rightOperand)
        default:
            break
        }
        
        currentOperand = String(calculationResult)
        removeOperandRedundantDotOrZero()
    }
    
    func add(a:Double!, b:Double!) {
        calculationResult = a + b
    }
    
    func subtract(a:Double!, b:Double!) {
        calculationResult =  a - b
    }
    
    func multiply(a:Double!, b:Double!) {
        calculationResult = a * b
    }
    
    func divide(a:Double!, b:Double!) {
        if(b == 0) {
            calculationResult = 0
        } else {
            calculationResult = a / b
        }
    }
    
    func reset() {
        calculationResult = 0
        currentOperand = "0"
        history.removeAll()
        while(!expression.empty()) {
            expression.pop()
        }
    }
    
    func percentage() {
        var operand:Double! = Double(currentOperand)
        operand = operand * 0.01
        currentOperand = String(operand)
    }
    
    func toggleSign() {
        if(currentOperand.prefix(1) == "-") {
            currentOperand.removeFirst()
        } else {
            currentOperand = "-" + currentOperand
        }
    }
    
    func removeOperandRedundantDotOrZero() {
        if(currentOperand.contains(".")) {
            while(currentOperand.last == "0") {
                currentOperand.removeLast()
            }
            if(currentOperand.last == ".") {
                currentOperand.removeLast()
            }
        }
    }
    
    func getHistory() -> String {
        return history.joined(separator: " ")
    }
}
