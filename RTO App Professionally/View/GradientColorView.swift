//
//  GradientColorView.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 01/10/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

@IBDesignable
class GradientColorView: UIView {
    
    @IBInspectable var topColor = UIColor(displayP3Red: 72/255, green: 85/255, blue: 99/255, alpha: 1) {
        
        didSet {
            
            self.setNeedsLayout()
        }
        
    }
    
    @IBInspectable var bottomColor = UIColor(displayP3Red: 41/255, green: 50/255, blue: 60/255, alpha: 1) {
        
        didSet {
            self.setNeedsLayout()
        }
        
    }
    
    
    override func layoutSubviews() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    
    
}
