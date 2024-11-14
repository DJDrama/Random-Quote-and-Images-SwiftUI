//
//  RandomImageListViewModel.swift
//  RandomQuoteAndImages
//
//  Created by Dongjun Lee on 11/14/24.
//

import Foundation
import UIKit

@MainActor
class RandomImageListViewModel: ObservableObject {
    
    @Published var randomImages: [RandomImageViewModel] = []
    
    let webService = WebService()
    func getRandomImages(ids: [Int]) async {
        do{
            let randomImages: [RandomImage] = try await webService.getRandomImages(ids: ids)
            // published properties should be set in main thread -> use @MainActor
            self.randomImages = randomImages.map(RandomImageViewModel.init)
        }catch {
            print("Error: \(error)")
        }
    }
}

struct RandomImageViewModel: Identifiable {
    let id = UUID()
    fileprivate let randomImage: RandomImage
    
    var image: UIImage? {
        UIImage(data: randomImage.image)
    }
    
    var quote: String {
        randomImage.quote.content
    }
}
