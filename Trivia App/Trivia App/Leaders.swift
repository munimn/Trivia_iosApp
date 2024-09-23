//
//  Leaders.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/18/22.
//

import Foundation
class Leaders : Codable {
    
    var name : String
    var answered : Int
    var score : Int
    
    init() {
        
        name = ""
        answered = 0
        score = 0
    }
}
