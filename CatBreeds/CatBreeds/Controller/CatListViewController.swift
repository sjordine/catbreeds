//
//  ViewController.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import UIKit

class CatListViewController: UIViewController {
    
    @IBOutlet weak var catBreedList: UITableView!
    
    var breeds:[CatBreedInfo] = []
    let catServices = CatServices()

    override func viewDidLoad() {
        super.viewDidLoad()
        catBreedList.dataSource = self
        catBreedList.delegate = self
        Task {
            do {
                let breedsData = try await catServices.retrieveCatBreeds()

                breeds = prepareBreedsToPresent(breedsData: breedsData)
                catBreedList.reloadData()
            } catch {
                // 4 - Present error, if any
                showErrorAlert()
            }
        }
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


extension CatListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatBreedCell",
                                                 for: indexPath)
        
        let currentBreed = breeds[indexPath.row]
        
        if let cell = cell as? CatBreedTableViewCell {
            
            cell.breedName.text = currentBreed.breed
            cell.countryName.text = currentBreed.countryName
            cell.countryFlag.text = currentBreed.flag
            cell.coatIcon.image = UIImage(named: currentBreed.coatIcon)
            cell.layoutIfNeeded()
        }
        
        return cell
    }
    
    
}

extension CatListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


