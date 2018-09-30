//
//  PracticeQuestionCell.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 26/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class PracticeQuestionCell: UITableViewCell {
    
    @IBOutlet weak var questionLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupView(practice: Practice) {
        
        questionLbl.text = practice.question
        
    }
    

}
