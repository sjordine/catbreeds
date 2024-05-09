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
            CatBreedCell(breed: breed)
        }
        .alert(isPresented: $viewModel.presentError) {
            Alert(
                title: Text("Error!"),
                message: Text("An error ocurred while getting cat breeds. Please contact suport!")
            )
        }
        .task {
            await viewModel.fetchBreeds()
        }
        
    }
}

#Preview {
    CatListView()
}
