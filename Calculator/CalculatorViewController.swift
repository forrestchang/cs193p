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
        let digit = sender.currentTitle!
        
        if hasTyeped {
            display.text = display.text! + digit
        } else {
            display.text = digit
            hasTyeped = true
        }
        
        opStack.append(sender.currentTitle!)
    }
    
    @IBAction func enter() {
        hasTyeped = false
        
        if opStack.count >= 1 {
            text = opStack.joinWithSeparator("")
            let lexer = Lexer(text: text)
            let parser = Parser(lexer: lexer)
            let result = parser.expr()
        
            display.text = String(result)
        
            opStack = [String]()
        }
    }
    
}
