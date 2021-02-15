//
//  Question.swift
//  snowmanlabs-ios-challenge
//
//  Created by José Matela Neto on 15/02/21.
//

import Foundation

struct Questions: Decodable {
    let questions: [Question]
}

enum Color: Int {
    case green = 1
    case salmon = 2
    case yellow = 3
    case blue = 4
    case none
}

struct Question: Decodable {
    let title, answer: String
    var color: Color.RawValue
    var expanded: Bool = false
}
