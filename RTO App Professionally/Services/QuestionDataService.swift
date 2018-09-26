//
//  QuestionDataService.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 26/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation
import Alamofire

class QuestionDataService {
    
    static let instance = QuestionDataService()
    
    
    // MARK: Get Text Questions Data from API
    
    func getTextQuestionData(url: String, completion: @escaping TextQuestionCompletionHandler) {
        
        guard let url = URL(string: url) else {return}
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.result.error {
                debugPrint(error.localizedDescription)
                return
            } else {
                
                guard let data = response.data else {return}
                let jsonDecoder = JSONDecoder()
                
                do{
                    let jsonData = try jsonDecoder.decode(TextQuestionElement.self, from: data)
                    completion(jsonData)
                    return
                } catch{
                    debugPrint(error.localizedDescription)
                    return
                }
            }
            
        }
        
    }
    
    
    // MARK: Get Image Question Data From API
    
    func getImageQuestionData(url: String, completion: @escaping ImageQuestionCompletionHandler) {
        
        guard let url = URL(string: url) else {return}
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.result.error {
                debugPrint(error.localizedDescription)
                return
            } else {
                
                guard let data = response.data else {return}
                let jsonDecoder = JSONDecoder()
                
                do{
                    let imageJson = try jsonDecoder.decode(ImageQuestionElement.self, from: data)
                    completion(imageJson)
                    return
                } catch{
                    debugPrint(error.localizedDescription)
                    return
                }
            }
            
            
            
        }
        
    }

    
    
}







