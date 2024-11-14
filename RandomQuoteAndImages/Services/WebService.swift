//
//  WebService.swift
//  RandomQuoteAndImages
//
//  Created by Dongjun Lee on 11/14/24.
//

import Foundation


enum NetworkError: Error {
    case badUrl
    case invalidImageId(Int)
    case decodingError
}


class WebService {
    
    func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
        
        var randomImages: [RandomImage] = []
        try await withThrowingTaskGroup(of: (Int, RandomImage).self) { group in
            for id in ids {
                group.addTask {
                    let randomImage = try await self.getRandomImage(id: id)
                    return (id, randomImage)
                }
                
                for try await (_, randomImage) in group {
                    randomImages.append(randomImage)
                }
            }
        }
        
        return randomImages
    }
    
    private func getRandomImage(id: Int) async throws  -> RandomImage{
        guard let url = Constants.Urls.getRandomImageUrl() else {
            throw NetworkError.badUrl
        }
        
        guard let randomQuoteUrl = Constants.Urls.randomQuoteUrl else {
            throw NetworkError.badUrl
        }
        
        // Concurrently
        async let (imageData, _) = URLSession.shared.data(from:url)
        async let (randomQuoteData, _) = URLSession.shared.data(from:randomQuoteUrl)
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await randomQuoteData) else {
            throw NetworkError.decodingError
        }
        
        return RandomImage(image: try await imageData, quote: quote)
    }
}
