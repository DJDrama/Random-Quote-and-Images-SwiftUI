//
//  RandomImage.swift
//  RandomQuoteAndImages
//
//  Created by Dongjun Lee on 11/14/24.
//

import Foundation

struct RandomImage: Decodable {
    let image: Data
    let quote: Quote
}

struct Quote: Decodable {
    let content: String
}
