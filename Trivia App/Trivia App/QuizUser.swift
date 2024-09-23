//
//  QuizUser.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/15/22.
//


import Foundation

class QuizUser : Codable {
    var id : Int
    var name : String
    var password : String
    var key : String
    
    init() {
        id = 0
        name = ""
        password = ""
        key = ""
    }
}

