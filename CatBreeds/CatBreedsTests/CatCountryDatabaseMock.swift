//
//  CatCountryDatabaseMock.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 05/05/24.
//

import Foundation

@testable import CatBreeds

struct CatCountryDatabaseMock: CatDatabase {
    func retrieveCatBreeds() async throws -> [CatBreeds.CatBreed] {
        [CatBreed(breed: "Single name country",
                        country: "Botswana",
                        origin: "Natural",
                        coat: "Short",
                        pattern: "Coated"),
         CatBreed(breed: "Multi word name country",
                         country: "Saudi Arabia",
                         origin: "Natural",
                         coat: "Short",
                         pattern: "Coated"),
         CatBreed(breed: "Developed in a single name country",
                         country: "developed in Hungary (founding stock from Bulgaria)",
                         origin: "Natural",
                         coat: "Short",
                         pattern: "Coated"),
         CatBreed(breed: "Developed in a composed name country",
                         country: "developed in the United Arab Emirates (founding stock from Saudi Arabia)",
                         origin: "Natural",
                         coat: "Short",
                         pattern: "Coated")]

    }
    
    
}

