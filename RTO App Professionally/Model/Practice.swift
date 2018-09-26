//
//  Practice.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 26/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

typealias PracticeElement = [Practice]

struct Practice: Codable {
    
    let question: String
    let option1: String
    let option2: String
    let option3: String
    let answer: String
    
    enum CodingKeys: String, CodingKey {
        case question
        case option1 = "option_1"
        case option2 = "option_2"
        case option3 = "option_3"
        case answer
    }
}

