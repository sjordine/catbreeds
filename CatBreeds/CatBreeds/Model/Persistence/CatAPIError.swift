//
//  CatAPIError.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import Foundation

enum CatAPIError: Error {
    case invalidURL
    case invalidData
    case serverNotAvailable
    case serverError
}
