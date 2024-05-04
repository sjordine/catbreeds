//
//  CatServices.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import Foundation

struct CatServices {
    
    func retrieveCatBreeds() throws -> [CatBreed] {
        let data = try retrieveCatBreedsData()
        let breedList = try parseBreedData(from: data)
        let processedList = breedList.map { breedData in
            if breedData.country.contains("developed in") {
                return CatBreed(breed: breedData.breed,
                                country: "TO BE DEFINED",
                                origin: breedData.origin,
                                coat: breedData.coat,
                                pattern: breedData.pattern)
            } else {
                return breedData
            }
        }
        
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
    
}
