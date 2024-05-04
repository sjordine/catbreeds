//
//  CatServices.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import Foundation

struct CatServices {
    
    var countryDatabase = CountryDataBase.shared
    
    func retrieveCatBreeds() throws -> [CatBreedDetail] {
        // 1 - Retrieve data from an external source
        let data = try retrieveCatBreedsData()
        // 2 - Process it to json
        let breedList = try parseBreedData(from: data)
        // 3 - Additional computation to make data fits our (business) needs
        let processedList = adjustBreedCountries(from:breedList)
        
        return processedList
    }
    
    private func retrieveCatBreedsData() throws -> Data {
        if let file = Bundle.main.url(forResource: "CatBreeds", withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                return data
            } catch {
                throw CatBreedFileError.unableToReadFile
            }
        } else {
            throw CatBreedFileError.noBreedFile
        }
    }
    
    private func parseBreedData(from data: Data) throws -> [CatBreed] {
        do {
            let breedsData = try JSONDecoder().decode(Array<CatBreed>.self,
                                                      from: data)
            return breedsData
        } catch {
            throw CatBreedFileError.invalidData
        }
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
