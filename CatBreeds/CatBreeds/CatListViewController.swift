//
//  ViewController.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import UIKit

enum CatBreedFileError: Error {
    case noBreedFile
    case unableToReadFile
    case invalidData
}

class CatListViewController: UIViewController {
    
    @IBOutlet weak var catBreedList: UITableView!
    
    var breeds:[CatBreedInfo] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        catBreedList.dataSource = self
        Task {
            do {
                let breedsData = try retrieveCatBreeds()
                
                breeds = prepareBreedsToPresent(breedsData: breedsData)
                catBreedList.reloadData()
            } catch {
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
    
    func retrieveCatBreeds() throws -> [CatBreed] {
        let data = try retrieveCatBreedsData()
        return try parseBreedData(from: data)
    }
    
    func retrieveCatBreedsData() throws -> Data {
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
    
    func parseBreedData(from data: Data) throws -> [CatBreed] {
        do {
            let breedsData = try JSONDecoder().decode(Array<CatBreed>.self,
                                                      from: data)
            return breedsData
        } catch {
            throw CatBreedFileError.invalidData
        }
    }
    
    func prepareBreedsToPresent(breedsData: [CatBreed]) -> [CatBreedInfo] {
        breedsData.map { catBreed in
            let iconName = coatIcon(from: catBreed.coat)
            return CatBreedInfo(breed: catBreed.breed,
                                coatIcon: iconName)
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
            
            cell.coatIcon.image = UIImage(named: currentBreed.coatIcon)
            
            
        }
        
        return cell
    }
    
    
}


