//
//  PsychologistUIViewController.swift
//  Psychologist
//
//  Created by 张佳圆 on 5/9/16.
//  Copyright © 2016 Tisoga. All rights reserved.
//

import UIKit

class PsychologistUIViewController: UIViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let happinessViewController = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "sad": happinessViewController.happiness = 0
                    case "happy": happinessViewController.happiness = 100
                    case "none": happinessViewController.happiness = 50
                    default: break
                }
            }
        }
    }
}
