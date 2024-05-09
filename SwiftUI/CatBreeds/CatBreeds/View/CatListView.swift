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
            HStack {
                Image(breed.coatIcon)
                    .foregroundStyle(.blue)
                    .frame(width: 50,
                           height: 50)
                VStack {
                    Text(breed.breed)
                    HStack {
                        Text(breed.flag)
                        Text(breed.countryName)
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.presentError) {
            Alert(
                title: Text("Error!"),
                message: Text("An error ocurred while getting cat breeds. Please contact suport!")
            )
        }
        .onAppear {
            Task {
                await viewModel.fetchBreeds()
            }
        }
        
    }
}

#Preview {
    CatListView()
}
