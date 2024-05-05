//
//  CatServices.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import Foundation

struct CatServices {
    
    var countryDatabase = CountryDataBase.shared

    var catBreedDatabase: CatDatabase = CatAPIDataAccess()
    
    func retrieveCatBreeds() async throws -> [CatBreedDetail] {
        
        let breedList = try await catBreedDatabase.retrieveCatBreeds()
        let processedList = adjustBreedCountries(from:breedList)
        
        return processedList
    }

    private func adjustBreedCountries(from breedList: [CatBreed]) -> [CatBreedDetail] {
        breedList.map { breedData in
            adjustCountryName(breedData)
            
        }
    }
    
    private func adjustCountryName(_ breedData: CatBreed) -> CatBreedDetail {
        let searchDevelopedCountry = /developed in (the )*(?<developedCountry>.+?) \(./
        
        var countryName = breedData.country
        
        if let result = try? searchDevelopedCountry
            .firstMatch(in: breedData.country) {
            countryName = String(result.developedCountry)
        }
        
        let countryCode = countryDatabase.country(by: countryName)
        
        return CatBreedDetail(breed: breedData.breed,
                              country: countryName,
                              countryCode: countryCode?.cca2 ?? "",
                              origin: breedData.origin,
                              coat: breedData.coat,
                              pattern: breedData.pattern)
    }
    
}
