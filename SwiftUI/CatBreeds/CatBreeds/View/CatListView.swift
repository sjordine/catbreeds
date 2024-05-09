//
//  ContentView.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 09/05/24.
//

import SwiftUI

struct CatListView: View {
    
    @StateObject var viewModel = CatListViewModel()
    
    var body: some View {
        List(viewModel.breeds) { breed in
            Text(breed.breed)
        }.onAppear {
            Task {
                await viewModel.fetchBreeds()
            }
        }
    }
}

#Preview {
    CatListView()
}
