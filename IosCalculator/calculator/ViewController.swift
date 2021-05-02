//
//  ViewController.swift
//  calculator
//
//  Created by 詹昆宬 on 2021/4/28.
//

import UIKit

class ViewController: UIViewController {

    lazy var calculator = Calculator()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var historyLabel: UILabel!
    
    @IBOutlet var operandButtons: [UIButton]!
    
    @IBOutlet var operatorButtons: [UIButton]!
    
    @IBOutlet var funcButtons: [UIButton]!
    
    func setOperandBtnLayout() {
        for index in operandButtons.indices{
            let button = operandButtons[index]
            if(button.titleLabel?.text == "0") {
                button.layer.cornerRadius = 38
            } else {
                button.layer.cornerRadius = button.frame.width / 2
            }
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor.darkGray
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        }
    }
    
    func setOperatorBtnLayout() {
        for index in operatorButtons.indices{
            let button = operatorButtons[index]
            button.layer.cornerRadius = button.frame.width / 2
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor.orange
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        }
    }
    
    func setFuncBtnLayout() {
        for index in funcButtons.indices{
            let button = funcButtons[index]
            button.layer.cornerRadius = button.frame.width / 2
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor.lightGray
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setOperandBtnLayout()
        setOperatorBtnLayout()
        setFuncBtnLayout()
    }
    
    @IBAction func touchOperand(_ sender: UIButton) {
        if let touchOperand =  sender.titleLabel?.text {
            calculator.processInputOperand(input: touchOperand)
            updateViewFromModel()
        }
    }
    
    @IBAction func touchOperator(_ sender: UIButton) {
        if let touchOperator =  sender.titleLabel?.text {
            calculator.processInputOperator(input: touchOperator)
        }
    }
    
    @IBAction func touchEqual(_ sender: UIButton) {
        calculator.processInputEqual()
        updateViewFromModel()
    }
    
    @IBAction func touchReset(_ sender: Any) {
        calculator.reset()
        updateViewFromModel()
    }
    
    
    @IBAction func touchToggleSign(_ sender: Any) {
        calculator.toggleSign()
        updateViewFromModel()
    }
    
    
    @IBAction func touchPercentage(_ sender: Any) {
        calculator.percentage()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        resultLabel.text = calculator.currentOperand
        historyLabel.text = calculator.getHistory()
    }
    
}

