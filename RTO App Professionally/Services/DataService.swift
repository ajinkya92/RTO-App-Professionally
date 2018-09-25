//
//  DataService.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 25/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

class DataService {
    
    static let instance = DataService()
    
    // MARK: Category Implementation
    
    private let categories = [
        
        Category(image: "practice", title: "PRACTICE", description: "Test your knowledge without worrying about time"),
        Category(image: "question", title: "QUESTION", description: "List of questions & answers and meaning of read signs"),
        Category(image: "exam", title: "EXAM", description: "Time and question bound test exactly same as actual RTO test"),
        Category(image: "settings", title: "SETTINGS & HELP", description: "Language selection, forms, RTO office information and more")
    
    ]
    
    func getCategory() -> [Category] {
        
        return categories
    }
    
    
    
}
