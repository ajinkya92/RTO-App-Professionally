//
//  SegmentControlExt.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 25/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation
import UIKit

extension UISegmentedControl {
    
    func setupSegmentControl() {
        
        let font = UIFont(name: "AvenirNextCondensed-Medium", size: 20.0)!
        
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: font], for: .normal)
        self.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.6)
        
    }
    
}
