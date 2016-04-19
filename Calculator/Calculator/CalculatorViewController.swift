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
    
    var typedNumber = ""
    var hasTyped = false

    @IBAction func appendDigit(sender: UIButton) {
        let numberInput = sender.currentTitle!
        typedNumber = "\(typedNumber)\(numberInput)"
        if hasTyped {
            display.text = display.text! + sender.currentTitle!
        } else {
            display.text = sender.currentTitle!
            hasTyped = true
        }
    }
    
    
    @IBAction func operate(sender: UIButton) {
        hasTyped = false
        performanceDisplay.text = typedNumber + " " + sender.currentTitle!
        typedNumber = ""
    }
    
    
    @IBAction func enter() {
        hasTyped = false
        typedNumber = ""
    }
    

}
