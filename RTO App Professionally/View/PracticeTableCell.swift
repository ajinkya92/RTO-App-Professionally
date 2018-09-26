//
//  PracticeTableCell.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 26/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class PracticeTableCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var option1Lbl: UILabel!
    @IBOutlet weak var option2Lbl: UILabel!
    @IBOutlet weak var option3Lbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        innerView.clipsToBounds = true
        innerView.layer.cornerRadius = 20
        
    }
    
    func setupView(practice: Practice) {
        
        questionLbl.text = practice.question
        option1Lbl.text = "1. " + practice.option1
        option2Lbl.text = "2. " + practice.option2
        option3Lbl.text = "3. " + practice.option3
        
    }

}
