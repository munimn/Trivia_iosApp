//
//  Answer.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/18/22.
//

import Foundation
class Answer : Codable {
    var question : Int
    var response : Int
    
    
    init(response n : Int, question i : Int) {
        question = i
        response = n
    }
}
