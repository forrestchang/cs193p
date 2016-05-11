//
//  ViewController.swift
//  Autolayout
//
//  Created by 张佳圆 on 5/10/16.
//  Copyright © 2016 Tisoga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var secure: Bool = true { didSet { updateUI() }}
    
    private func updateUI() {
        passwordTextfield.secureTextEntry = secure
        passwordLabel.text = secure ? "SecurePassword" : "Password"
    }
    
    @IBAction func changeSecurity(sender: UIButton) {
        secure = !secure
    }
    
}

