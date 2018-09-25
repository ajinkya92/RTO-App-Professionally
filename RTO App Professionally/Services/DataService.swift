//
//  DataService.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 25/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation
import Alamofire

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
    
    
    
    // MARK: Fetching Image Question Data
    
    func getImageQuestionData(url: String, completion: @escaping ImageQuestionCompletionHandler) {
        
        guard let url = URL(string: url) else {return}
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.result.error {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            } else {
                
                guard let data = response.data else {return completion(nil)}
                let jsonDecoder = JSONDecoder()
                
                do{
                    let jsonData = try jsonDecoder.decode(ImageQuestion.self, from: data)
                    completion(jsonData)
                    return
                } catch{
                    debugPrint(error.localizedDescription)
                    completion(nil)
                    return
                }
            }
            
        }
        
    }
    
    
    
}
