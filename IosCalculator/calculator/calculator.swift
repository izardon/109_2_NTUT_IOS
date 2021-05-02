//
//  Calculator.swift
//  calculator
//
//  Created by 詹昆宬 on 2021/4/30.
//

import Foundation

class Calculator {
    var calculationResult:Decimal! = 0
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
    
    public func processInputOperand(input:String) {
        addHistory(elem: currentOperator)
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
    
    private func processExpression() {
        if(currentOperator != "" && expression.count() >= 3) {
            if(isPreviousOperatorPriorityGreaterThenOrEqualCurrentOperatorPriority()) {
                executeCalculation()
                saveOperandToExpression()
            } 
        }
    }
    
    private func saveOperatorToExpression() {
        if(currentOperator != "") {
            preOperatorPriority = operatorPriorityDict[currentOperator]
            expression.push(item: currentOperator)
            currentOperator = ""
        }
    }
    
    public func processInputEqual() {
        currentOperator = ""
        currentOperand = removeOperandRedundantDotOrZero(operand: currentOperand)
        addHistory(elem: currentOperand)
        saveOperandToExpression()
        
        if(expression.count() >= 3) {
            addHistory(elem: "=")
            
            while(expression.count() >= 3) {
                executeCalculation()
                expression.push(item: currentOperand)
            }
        } else {
            currentOperand = expression.pop()
            history.removeLast()
        }
    }
    
    public func processInputOperator(input: String) {
        currentOperand = removeOperandRedundantDotOrZero(operand: currentOperand)
        addHistory(elem: currentOperand)
        saveOperandToExpression()
        
        currentOperator = input
    }
    
    private func saveOperandToExpression() {
        if(currentOperand != "") {
            expression.push(item: currentOperand)
            currentOperand = ""
        }
    }
    
    private func isPreviousOperatorPriorityGreaterThenOrEqualCurrentOperatorPriority() -> Bool {
        return preOperatorPriority >= (operatorPriorityDict[currentOperator]!)
    }
    
    private func addHistory(elem: String) {
        if(elem != "") {
            history.append(elem)
        }
    }
    
    private func executeCalculation() {
        let rightOperand:Decimal! = Decimal(string: expression.pop()!)
        let calOperator = expression.pop()!
        let leftOperand:Decimal! = Decimal(string: expression.pop()!)
        
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
        
        currentOperand = removeOperandRedundantDotOrZero(operand: NSDecimalNumber(decimal: calculationResult).stringValue)
    }
    
    private func add(a:Decimal!, b:Decimal!) {
        calculationResult = a + b
    }
    
    private func subtract(a:Decimal!, b:Decimal!) {
        calculationResult =  a - b
    }
    
    private func multiply(a:Decimal!, b:Decimal!) {
        calculationResult = a * b
    }
    
    private func divide(a:Decimal!, b:Decimal!) {
        if(b == 0) {
            calculationResult = 0
        } else {
            calculationResult = a / b
        }
    }
    
    public func reset() {
        calculationResult = 0
        currentOperand = "0"
        history.removeAll()
        while(!expression.empty()) {
            expression.pop()
        }
    }
    
    public func percentage() {
        var operand:Double! = Double(currentOperand)
        operand = operand * 0.01
        currentOperand = String(operand)
    }
    
    public func toggleSign() {
        if(currentOperand.prefix(1) == "-") {
            currentOperand.removeFirst()
        } else {
            currentOperand = "-" + currentOperand
        }
    }
    
    private func removeOperandRedundantDotOrZero(operand: String) -> String {
        var formatOperand = operand
        if(formatOperand.contains(".")) {
            while(formatOperand.last == "0") {
                formatOperand.removeLast()
            }
            if(formatOperand.last == ".") {
                formatOperand.removeLast()
            }
        }
        return formatOperand
    }
    
    public func getHistory() -> String {
        return history.joined(separator: " ")
    }
}
