//
//  PracticeDataService.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 26/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation
import Alamofire

class PracticeDataService {
    
    static let instance = PracticeDataService()
    
    // MARK: Practice Api Call
    
    func getPracticeData(url: String, completion: @escaping PracticeCompletionHandler) {
        
        guard let url = URL(string: url) else {return}
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.result.error {
                debugPrint(error.localizedDescription)
                return
            } else {
                
                guard let data = response.data else {return}
                let jsonDecoder = JSONDecoder()
                
                do{
                    
                    let practiceJson = try jsonDecoder.decode(PracticeElement.self, from: data)
                    completion(practiceJson)
                    
                } catch{
                    debugPrint(error.localizedDescription)
                    return
                }
                
                
            }
            
        }
    
    }
    
}
