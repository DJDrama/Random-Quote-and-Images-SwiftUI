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
        NavigationView{
            List(randomImageListVM.randomImages) { randomImage in
                HStack {
                    randomImage.image.map {
                        Image(uiImage: $0)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    Text(randomImage.quote)
                }
            }
            
            .task {
                 await randomImageListVM.getRandomImages(ids: Array(100...120))
            }
            .navigationTitle("Random Images/Quotes")
            .navigationBarItems(trailing: Button(action: {
                // Unstructured Task
                Task {
                    await randomImageListVM.getRandomImages(ids: Array(100...120))
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
        }
    }
}

#Preview {
    ContentView()
}
