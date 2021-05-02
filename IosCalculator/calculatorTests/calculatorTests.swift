//
//  calculatorTests.swift
//  calculatorTests
//
//  Created by 詹昆宬 on 2021/4/28.
//

import XCTest
@testable import calculator

class calculatorTests: XCTestCase {

    var calculator: Calculator!
    
    override func setUpWithError() throws {
      try super.setUpWithError()
      calculator = Calculator()
    }

    override func tearDownWithError() throws {
      calculator = nil
      try super.tearDownWithError()
    }
    
    func test_update_current_operand_with_integer_input() throws {
        // Given
        let inputs:[String] = ["9", "5", "3", "6"]
        
        // When
        for index in inputs.indices{
            calculator.processInputOperand(input: inputs[index])
        }
        
        // Then
        XCTAssertEqual("9536", calculator.currentOperand)
    }
    
    func test_update_current_operand_with_float_input() throws {
        // Given
        let inputs:[String] = ["9", "5", ".", "0", "3", "6"]
        
        // When
        for index in inputs.indices{
            calculator.processInputOperand(input: inputs[index])
        }
        
        // Then
        XCTAssertEqual("95.036", calculator.currentOperand)
    }
    
    func test_update_current_operand_with_multiple_dot_input() throws {
        // Given
        let inputs:[String] = ["9", ".", ".", "0", "3", "6"]
        
        // When
        for index in inputs.indices{
            calculator.processInputOperand(input: inputs[index])
        }
        
        // Then
        XCTAssertEqual("9.036", calculator.currentOperand)
    }
    
    func test_update_current_operand_with_prefix_multiple_zero_input() throws {
        // Given
        let inputs:[String] = ["0", "0", "8", "8", "5"]
        
        // When
        for index in inputs.indices{
            calculator.processInputOperand(input: inputs[index])
        }
        
        // Then
        XCTAssertEqual("885", calculator.currentOperand)
    }
    
    func test_remove_operand_redundant_zero_after_dot() throws {
        // 5.2100 +
        
        // Given
        calculator.processInputOperand(input: "5.2100")

        // When
        calculator.processInputOperator(input: "+")

        // Then
        XCTAssertEqual("5.21", calculator.expression.peek())
        XCTAssertEqual("5.21", calculator.getHistory())
    }

    func test_remove_operand_redundant_zero_and_dot() throws {
        // 5.0 +
        
        // Given
        calculator.processInputOperand(input: "5.0")

        // When
        calculator.processInputOperator(input: "+")

        // Then
        XCTAssertEqual("5", calculator.expression.peek())
        XCTAssertEqual("5", calculator.getHistory())
    }
    
    func test_expression_when_input_one_operator() {
        // 15 +
        
        // Given
        calculator.processInputOperand(input: "1")
        calculator.processInputOperand(input: "5")
        
        // When
        calculator.processInputOperator(input: "+")
        
        // Than
        XCTAssertEqual("15", calculator.expression.peek())
    }
    
    func test_one_operator_expression_calculation_result() {
        // 15 + 1.25 = 16.25
        
        // Given
        calculator.processInputOperand(input: "1")
        calculator.processInputOperand(input: "5")
        
        calculator.processInputOperator(input: "+")
        
        calculator.processInputOperand(input: "1")
        calculator.processInputOperand(input: ".")
        calculator.processInputOperand(input: "2")
        calculator.processInputOperand(input: "5")
        
        // When
        calculator.processInputEqual()
        
        // Than
        XCTAssertEqual(16.25, calculator.calculationResult)
        XCTAssertEqual("16.25", calculator.currentOperand)
    }
    
    func test_first_input_is_operator() {
        // + 5 = 5
        
        //Given
        calculator.processInputOperator(input: "+")
        
        calculator.processInputOperand(input: "5")
        
        // When
        calculator.processInputEqual()
        
        // Then
        XCTAssertEqual(5, calculator.calculationResult)
        XCTAssertEqual("5", calculator.currentOperand)
    }
    
    func test_continue_input_operator() {
        // 1 + × + 4 = 5
        
        //Given
        calculator.processInputOperand(input: "1")
        
        calculator.processInputOperator(input: "+")
        calculator.processInputOperator(input: "×")
        calculator.processInputOperator(input: "+")
        
        calculator.processInputOperand(input: "4")
        
        // When
        calculator.processInputEqual()
        
        // Then
        XCTAssertEqual(5, calculator.calculationResult)
        XCTAssertEqual("5", calculator.currentOperand)
        XCTAssertEqual("1 + 4 =", calculator.getHistory())
    }
    
    func test_toggle_operand_negative_sign() throws {
        // Given
        calculator.currentOperand = "5"
        
        // When
        calculator.toggleSign()
        
        // Then
        XCTAssertEqual("-5", calculator.currentOperand)
    }
    
    func test_toggle_operand_positive_sign() throws {
        // Given
        calculator.currentOperand = "-5"
        
        // When
        calculator.toggleSign()
        
        // Then
        XCTAssertEqual("5", calculator.currentOperand)
    }
    
    func test_percentage() {
        // 1 %
        
        //Given
        calculator.processInputOperand(input: "1")
        
        // When
        calculator.percentage()
        
        // Then
        XCTAssertEqual("0.01", calculator.currentOperand)
    }
    
    func test_reset() throws {
        // Given
        calculator.currentOperand = "11"
        calculator.history = ["5", "+", "11"]
        calculator.calculationResult = 5
        calculator.expression.push(item: "5")
        calculator.expression.push(item: "+")
        calculator.expression.push(item: "11")
        
        // When
        calculator.reset()
        
        // Then
        XCTAssertEqual("0", calculator.currentOperand)
        XCTAssertEqual([], calculator.history)
        XCTAssertEqual(0, calculator.calculationResult)
        XCTAssertEqual("", calculator.currentOperator)
        XCTAssertEqual(true, calculator.expression.empty())
        
    }
    
    func test_expression_of_two_operator_with_same_priority() throws {
        // 11 + 2.5 + 5 = 18.5
        
        //Given
        calculator.processInputOperand(input: "11")
        
        calculator.processInputOperator(input: "+")
        
        calculator.processInputOperand(input: "2.5")
        
        calculator.processInputOperator(input: "+")
        
        calculator.processInputOperand(input: "5")
        
        // When
        calculator.processInputEqual()
        
        // Then
        XCTAssertEqual(18.5, calculator.calculationResult)
        XCTAssertEqual("18.5", calculator.currentOperand)
        XCTAssertEqual("11 + 2.5 + 5 =", calculator.getHistory())
    }
    
    func test_expression_of_two_operator_when_second_priority_greater_than_first_priority() throws {
        // 10 + 2.5 × 4 = 20

        //Given
        calculator.processInputOperand(input: "10")

        calculator.processInputOperator(input: "+")

        calculator.processInputOperand(input: "2.5")

        calculator.processInputOperator(input: "×")

        calculator.processInputOperand(input: "4")

        // When
        calculator.processInputEqual()

        // Then
        XCTAssertEqual(20, calculator.calculationResult)
        XCTAssertEqual("20", calculator.currentOperand)
    }
    
    func test_expression_of_three_operator_when_first_operator_priority_is_smallest() throws {
        // 10 + 2.5 × 4 × 2 = 30

        //Given
        calculator.processInputOperand(input: "10")

        calculator.processInputOperator(input: "+")

        calculator.processInputOperand(input: "2.5")

        calculator.processInputOperator(input: "×")

        calculator.processInputOperand(input: "4")
        
        calculator.processInputOperator(input: "×")

        calculator.processInputOperand(input: "2")

        // When
        calculator.processInputEqual()

        // Then
        XCTAssertEqual(30, calculator.calculationResult)
        XCTAssertEqual("30", calculator.currentOperand)
    }
    
    func test_expression_of_three_operator_when_operator_priority_is_complex() throws {
        // 10 + 2.5 × 4 × 10 + 40 ÷ 20 = 112

        //Given
        calculator.processInputOperand(input: "10")

        calculator.processInputOperator(input: "+")

        calculator.processInputOperand(input: "2.5")

        calculator.processInputOperator(input: "×")

        calculator.processInputOperand(input: "4")
        
        calculator.processInputOperator(input: "×")

        calculator.processInputOperand(input: "10")
        
        calculator.processInputOperator(input: "+")

        calculator.processInputOperand(input: "40")
        
        calculator.processInputOperator(input: "÷")

        calculator.processInputOperand(input: "20")

        // When
        calculator.processInputEqual()

        // Then
        XCTAssertEqual(112, calculator.calculationResult)
        XCTAssertEqual("112", calculator.currentOperand)
        XCTAssertEqual("10 + 2.5 × 4 × 10 + 40 ÷ 20 =", calculator.getHistory())
        XCTAssertEqual("112", calculator.expression.peek())
        
    }
    
    func test_divided_by_zero() throws {
        // 5 ÷ 0 = 0
        
        // Given
        calculator.processInputOperand(input: "5")
        
        calculator.processInputOperator(input: "÷")

        calculator.processInputOperand(input: "0")

        // When
        calculator.processInputEqual()
        
        // Then
        XCTAssertEqual("0", calculator.currentOperand)
    }
    
    func test_first_step_input_equal() throws {
        // =

        // Given
        
        // When
        calculator.processInputOperator(input: "=")

        // Then
        XCTAssertEqual("", calculator.currentOperand)
        XCTAssertEqual("0", calculator.getHistory())
    }
    
    func test_input_equal_when_expression_cannot_calculate() throws {
        // 12 =

        // Given
        calculator.processInputOperand(input: "12")

        // When
        calculator.processInputEqual()
        
        // Then
        XCTAssertEqual("12", calculator.currentOperand)
        XCTAssertEqual("", calculator.getHistory())
    }
    
    func test_continue_input_equal_and_then_check_history() throws {
        // 1 = = =

        // Given
        calculator.processInputOperand(input: "1")

        // When
        calculator.processInputEqual()
        calculator.processInputEqual()
        calculator.processInputEqual()
        
        // Then
        XCTAssertEqual("1", calculator.currentOperand)
        XCTAssertEqual("", calculator.getHistory())
    }
    
    func test_input_equal_when_expression_cannot_calculate_and_then_update_expression_to_can_be_calculated() throws {
        // 1 = = = + 5 = 6

        // Given
        calculator.processInputOperand(input: "1")
        calculator.processInputEqual()
        calculator.processInputEqual()
        calculator.processInputEqual()
        calculator.processInputOperator(input: "+")
        calculator.processInputOperand(input: "5")

        // When
        calculator.processInputEqual()
        
        // Then
        XCTAssertEqual("6", calculator.currentOperand)
        XCTAssertEqual("1 + 5 =", calculator.getHistory())
    }
}
