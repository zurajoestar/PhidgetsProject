//
//  QuestionFunction.swift
//  PhidgetsProject
//
//  Created by Cristina Lopez on 2018-11-08.
//  Copyright © 2018 Cristina Lopez. All rights reserved.
//

import Foundation

class Question {
    
    let questionText : String
    let answer : Bool
    
    init(text: String, correctAnswer: Bool) {
        questionText = text
        answer = correctAnswer
    }
    
}
