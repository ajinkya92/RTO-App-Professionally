//
//  Constants.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 25/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

let TEXTQUESTION_URL = "http://mapi.trycatchtech.com/v1/rto/text_question_list"
let IMAGEQUESTION_URL = "http://mapi.trycatchtech.com/v1/rto/image_question_list"
let PRACTICE_URL = "http://mapi.trycatchtech.com/v1/rto/practice_question_list"
let EXAM_URL = "http://mapi.trycatchtech.com/v1/rto/exam_question_list"




// MARK: Completion Handlers

typealias TextQuestionCompletionHandler = (TextQuestionElement) -> ()
typealias ImageQuestionCompletionHandler = (ImageQuestionElement) -> ()
typealias PracticeCompletionHandler = (PracticeElement) -> ()
typealias ExamCompletionHandler = (Exam?) -> ()
