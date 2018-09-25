//
//  ImageQuestionCell.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 26/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit
import Kingfisher

class ImageQuestionCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var questionImageName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.innerView.clipsToBounds = true
        self.innerView.layer.cornerRadius = 10
    }
    
    func setupView(imageQuestion: ImageQuestion) {
        
        questionImageName.text = imageQuestion.name
        
        let url = URL(string: imageQuestion.image)
        
        questionImage.kf.setImage(with: url)
        
        
    }

}
