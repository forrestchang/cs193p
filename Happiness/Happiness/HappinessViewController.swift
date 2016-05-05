//
//  HappinessViewController.swift
//  Happiness
//
//  Created by 张佳圆 on 5/4/16.
//  Copyright © 2016 Tisoga. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
        }
    }
    
    // Model
    var happiness: Int = 9 { // 0 - 100
        didSet {
            happiness = min(max(happiness, 0), 100)
            print("Happiness = \(happiness)")
            updateUI()
        }
    }
    // End Model
    
    private func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
}
