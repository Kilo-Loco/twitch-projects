//
//  DefineSearchTermResponse.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import Foundation

struct DefineSearchTermResponse: Decodable {
    let list: [Term]
}
