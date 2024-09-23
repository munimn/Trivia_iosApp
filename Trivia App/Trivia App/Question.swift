//
//  Question.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/15/22.
//

import Foundation
class Question : Codable {
    var quiz : Int
    var question : String
    var options : String
    var answer : Int
    
    init(question n : String,options o : String,answer a : Int) {
        quiz = -1
        question = n
        options = o
        answer = a
        
    }
}
