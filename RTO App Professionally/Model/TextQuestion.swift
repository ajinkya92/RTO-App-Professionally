//
//  TextQuestion.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 25/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

typealias TextQuestionElement = [TextQuestion]

struct TextQuestion: Codable {

    let question: String
    let answer: String

}
