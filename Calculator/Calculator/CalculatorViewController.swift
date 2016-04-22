//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by 张佳圆 on 4/18/16.
//  Copyright © 2016 Tisoga. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var performanceDisplay: UILabel!
    
    var brain = CalculatorBrain()
    
    var typedNumber = ""
    var hasTyped = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let numberInput = sender.currentTitle!
        typedNumber = "\(typedNumber)\(numberInput)"
        if hasTyped {
            display.text = display.text! + numberInput
        } else {
            display.text = numberInput
            hasTyped = true
        }
        
        // performance display
//        performanceDisplay.text = "\(performanceDisplay.text!) \(numberInput)"
    }
    
    
    @IBAction func operate(sender: UIButton) {
        //hasTyped = false
        if hasTyped {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performanceOperation(operation) {
                displayNumber = result
            } else {
                displayNumber = 0
            }
        }
        
//        performanceDisplay.text = performanceDisplay.text! + " " + sender.currentTitle!
//        typedNumber = ""
    }
    
    
    @IBAction func enter() {
        hasTyped = false
        if let result = brain.pushOperand(displayNumber) {
            displayNumber = result
        } else {
            displayNumber = 0
        }
        
        var lexer = Lexer(text: "1 + 2")
        print(lexer.getNextToken())
        
//        typedNumber = ""
    }
    
    var displayNumber: Double {
        set {
            display.text = "\(newValue)"
            hasTyped = false
        }
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
    }
    
}
