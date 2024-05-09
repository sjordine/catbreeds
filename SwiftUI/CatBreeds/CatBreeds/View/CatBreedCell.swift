//
//  CatBreedCell.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 09/05/24.
//

import Foundation
import SwiftUI

struct CatBreedCell: View {
    
    var breed: CatBreedInfo
    
    var body: some View {
        HStack {
            Image(breed.coatIcon)
                .foregroundStyle(.blue)
                .frame(width: 50,
                       height: 50)
            VStack(alignment: .leading) {
                Text(breed.breed)
                HStack {
                    Text(breed.flag)
                    Text(breed.countryName)
                }
            }
        }
    }
    
}
