//
//  QuestionBank.swift
//  PhidgetsProject
//
//  Created by Cristina Lopez on 2018-11-08.
//  Copyright © 2018 Cristina Lopez. All rights reserved.
//

import Foundation


class QuestionBank {
    

    var list = [Question]()

    init() {
        list.append(Question(text: "Milk is put before the cerials.", correctAnswer: false))
    
        list.append(Question(text: "The world is flat.", correctAnswer: false))
    
        list.append(Question(text: "Acceleration due to gravoty is 9.81 m/s", correctAnswer: false))
    }

}
