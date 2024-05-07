//
//  CatListViewCodeViewController.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 07/05/24.
//

import UIKit

class CatListViewCodeViewController: UIViewController {
    
    let catServices = CatServices()
    
    private lazy var catListView: CatListView = {
            return CatListView()
        }()
    
    override func loadView() {
        super.loadView()
        
        self.view = catListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        catListView.setup()

        
        Task {
            do {
                let breedsData = try await catServices.retrieveCatBreeds()

                let breeds = prepareBreedsToPresent(breedsData: breedsData)
                catListView.update(breeds:breeds)
                
                
            } catch {
                // 4 - Present error, if any
                showErrorAlert()
            }
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
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error!",
                                      message: "An error ocurred while getting cat breeds. Please contact suport!",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }

}
