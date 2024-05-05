//
//  CatAPIDataAccess.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import Foundation

struct CatAPIDataAccess: CatDatabase {
    
    func retrieveCatBreeds() async throws -> [CatBreed] {
        let data = try await retrieveCatBreedsData()
        let breedList = try parseBreedData(from: data)
        
        return breedList
    }
    
    private func retrieveCatBreedsData() async throws -> Data {
        do {
            if let url = URL(string: "https://catfact.ninja/breeds?limit=50") {
                let (data, response) = try await URLSession.shared.data(from: url)
                if let response = response as? HTTPURLResponse,
                   response.statusCode == 200 {
                    return data
                } else {
                    throw CatAPIError.serverError
                }
            } else {
                throw CatAPIError.invalidURL
            }
        } catch {
            throw CatAPIError.serverNotAvailable
        }
    }
    
    private func parseBreedData(from data: Data) throws -> [CatBreed] {
        do {
            let breedsData = try JSONDecoder().decode(CatAPIData.self,
                                                      from: data)
            return breedsData.data
        } catch {
            throw CatAPIError.invalidData
        }
    }
    
}
