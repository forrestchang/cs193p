//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by 张佳圆 on 4/27/16.
//  Copyright © 2016 Tisoga. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var hasTyeped = false
    var text: String = ""
    
    var opStack = [String]()

    @IBAction func textButton(sender: UIButton) {
        opStack.append(sender.currentTitle!)
        display.text = opStack.joinWithSeparator("")
    }
    
    @IBAction func enter() {
        hasTyeped = false
        
        if opStack.count >= 1 {
            text = opStack.joinWithSeparator("")
            if let result = calculate(text) {
                display.text = String(result)
                //opStack = [String]()
            }
        }
    }
    
    @IBAction func clear() {
        if opStack.count > 0 {
            opStack.removeLast()
            display.text = opStack.joinWithSeparator("")
        } else {
            display.text = String(0)
        }
    }
    
    func calculate(text: String) -> Double? {
        let lexer = Lexer(text: text)
        
        do {
            let parser = try Parser(lexer: lexer)
            let result = try parser.expr()
            opStack = []
            return result
        } catch {
            display.text = "Error!"
            opStack = []
        }
        
        return nil
    }
}
