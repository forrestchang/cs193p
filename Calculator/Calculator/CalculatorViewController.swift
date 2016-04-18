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
    
    var hasTyped: Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        let currentNumber = display.text
        let number = sender.currentTitle!
        if hasTyped {
            display.text = currentNumber! + number
        } else {
            display.text = number
            hasTyped = true
        }
        
    }
}
