//
//  CategoryCell.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 25/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func setupCategoryView(category: Category) {
        
        categoryImage.image = UIImage(named: category.image)
        categoryTitle.text = category.title
        categoryDescription.text = category.description
        
    }
    
    

}
