//
//  CatBreedInfo.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import Foundation


struct CatBreedInfo: Identifiable {
    
    var id: String {
        breed
    }
    
    var breed: String
    var countryName: String
    var coatIcon: String
    var flag:String
}
