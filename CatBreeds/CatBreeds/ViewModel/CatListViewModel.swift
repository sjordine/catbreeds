//
//  CatListViewModel.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 07/05/24.
//

import Foundation

class CatListViewModel:NSObject {
    
    let catServices = CatServices()
    
    func fetchBreeds() async {
        do {
            let breedsData = try await catServices.retrieveCatBreeds()
            
            let breeds = prepareBreedsToPresent(breedsData: breedsData)
            
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: NSNotification.Name("UpdateBreedList"),
                                    object: nil,
                                    userInfo: ["breeds":breeds])
        } catch {
            
        }
    }
    
    func prepareBreedsToPresent(breedsData: [CatBreedDetail]) -> [CatBreedInfo] {
        breedsData.map { catBreed in
            let iconName = coatIcon(from: catBreed.coat)
            let flag = flag(country: catBreed.countryCode)
            return CatBreedInfo(breed: catBreed.breed,
                                countryName: catBreed.country,
                                coatIcon: iconName,
                                flag: flag)
        }
    }
    
    func coatIcon(from coatName: String) -> String {
        switch coatName.lowercased() {
        case "short":
            return "shortIcon"
        case "long":
            return "longIcon"
        case "hairless/furry down":
            return "hairlessIcon"
        default:
            return ""
        }
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    
}
