//
//  ContentView.swift
//  RandomQuoteAndImages
//
//  Created by Dongjun Lee on 11/14/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var randomImageListVM = RandomImageListViewModel()
    
    var body: some View {
        List(randomImageListVM.randomImages) { randomImage in
            HStack {
                randomImage.image.map {
                    Image(uiImage: $0)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Text(randomImage.quote)
            }
        }.task {
            await randomImageListVM.getRandomImages(ids: Array(100...120))
        }
    }
}

#Preview {
    ContentView()
}
