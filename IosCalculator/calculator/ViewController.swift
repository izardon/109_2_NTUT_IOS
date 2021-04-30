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
    
    @IBOutlet var operandButtons: [UIButton]!
    
    @IBOutlet var operatorButtons: [UIButton]!
    
    @IBOutlet var specialButtons: [UIButton]!
    
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
    
    func setSpecialBtnLayout() {
        for index in specialButtons.indices{
            let button = specialButtons[index]
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
        setSpecialBtnLayout()
    }
    
    @IBAction func touchOperand(_ sender: UIButton) {
        if let operand =  sender.titleLabel?.text {
            print(operand)
        }
    }
    
    @IBAction func touchSpecial(_ sender: UIButton) {
        if let special =  sender.titleLabel?.text {
            print(special)
        }
    }
    
    @IBAction func touchOperator(_ sender: UIButton) {
        if let myOperator =  sender.titleLabel?.text {
            print(myOperator)
        }
    }
    
}

