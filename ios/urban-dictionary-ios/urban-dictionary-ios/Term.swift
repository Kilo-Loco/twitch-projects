//
//  Term.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import Foundation

struct Term: Decodable {
    let word: String
    let definition: String
    let likes: Int
    let dislikes: Int
    
    var strippedDefinition: String {
        definition
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
    }
    
    private enum CodingKeys: String, CodingKey {
        case word, definition
        case likes = "thumbs_up"
        case dislikes = "thumbs_down"
    }
}

extension Term: Hashable {}
