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
            //1 - Could return as an empty list! Why?
            let breedsData = retrieveCatBreeds()
            
            if !breedsData.isEmpty {
                breeds = prepareBreedsToPresent(breedsData: breedsData)
                catBreedList.reloadData()
            }
        }
    }
    
    func retrieveCatBreeds() -> [CatBreed] {
        do {
            let data = try retrieveCatBreedsData()
            return parseBreedData(from: data)
        } catch {
            //1.1 - Empty list due to an error retrieving data
            return []
        }
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
    
    func parseBreedData(from data: Data) -> [CatBreed] {
        do {
            let breedsData = try JSONDecoder().decode(Array<CatBreed>.self,
                                                      from: data)
            return breedsData
        } catch {
            //1.2.1 - An empty list due to an error decoding JSON
            // according to expected structure (invalid data format)
            return []
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


