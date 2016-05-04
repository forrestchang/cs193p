//
//  FaceView.swift
//  Happiness
//
//  Created by 张佳圆 on 5/4/16.
//  Copyright © 2016 Tisoga. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var lineWidth: CGFloat = 3.0 { didSet { setNeedsDisplay() }}
    var color: UIColor = UIColor.blackColor() { didSet { setNeedsDisplay() }}
    var scale: CGFloat = 0.90
    
    var faceCenter: CGPoint {
        return convertPoint(center, toView: superview)
    }
    
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
    }
    
    
    

}
