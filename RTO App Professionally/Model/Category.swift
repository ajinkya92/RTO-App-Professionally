//
//  Category.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 25/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

struct Category {
    
    private (set) var image: String
    private (set) var title: String
    private (set) var description: String
    
    init(image: String, title: String, description: String) {
        
        self.image = image
        self.title = title
        self.description = description
    }
}
