//
//  CountryDataBase.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import Foundation

struct CountryDataBase {
    
    public static let shared = CountryDataBase()
    
    private var countries:[Country] = []
    private var countryByName:[String:Country] = [:]
    
    private init() {
        if let file = Bundle.main.url(forResource: "Countries", withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                countries = try JSONDecoder().decode(Array<Country>.self,
                                                     from: data)
                countryByName = countries.reduce([:]) { partialResult, country in
                    partialResult.merging([country.name.common: country]) { old, new in
                        new
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func country(by commonName:String) -> Country? {
        countryByName[commonName]
    }
    
}
