//
//  Quiz.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/15/22.
//

import Foundation

class Quiz : Codable {
    var id : Int
    var title : String
    var publisher : Int
    
    init(title n : String) {
        id = 0
        title = n
        publisher = 0
    }
}
