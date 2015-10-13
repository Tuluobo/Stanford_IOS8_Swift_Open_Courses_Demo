//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by 王浩 on 15/9/24.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    var userIsInTheMiddleOfTypingANmuber = false
    let brain = CalculatorBrain()
    var displayValue:Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANmuber = false
        }
    }
    
    @IBOutlet weak var display: UILabel!
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANmuber {
            display.text! += digit
        }else{
            userIsInTheMiddleOfTypingANmuber = true
            display.text = digit
        }
    }
    
    @IBAction func enter() {
        
        userIsInTheMiddleOfTypingANmuber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        
        if userIsInTheMiddleOfTypingANmuber {
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }
        }else{
            displayValue = 0
        }
    }
//    /**
//    *
//    * 在OC中不支持方法重载，但是swift中支持方法重载
//    * 自己的viewController继承自OC的UIViewController，所以public方法都不支持重载
//    * 这里将重载方法设置为private。（对公开课中的代码做的修改）
//    *
//    */
//    private func performOperation(operation: (Double,Double)->Double){
//        if operandStack.count>=2 {
//            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
//            enter()
//        }
//    }
//    private func performOperation(operation: Double -> Double){
//        if operandStack.count>=1 {
//            displayValue = operation(operandStack.removeLast())
//            enter()
//        }
//    }

}

