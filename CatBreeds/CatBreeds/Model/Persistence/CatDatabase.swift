//
//  CatDatabase.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import Foundation

protocol CatDatabase {
    func retrieveCatBreeds() async throws -> [CatBreed]
}
