//
//  TextQuestionCell.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 25/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class TextQuestionCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 10
        
    }
    
    func setupView(textQuestion: TextQuestion) {
        
        questionLbl.text = textQuestion.question
        answerLbl.text = textQuestion.answer
        
    }

}
