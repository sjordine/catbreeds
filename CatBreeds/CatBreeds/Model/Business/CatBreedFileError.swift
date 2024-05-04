//
//  CatBreedFileError.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import Foundation

enum CatBreedFileError: Error {
    case noBreedFile
    case unableToReadFile
    case invalidData
}
