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

    override func viewDidLoad() {
        super.viewDidLoad()
        catBreedList.dataSource = self
        Task {
            
            let breedsData = retrieveCatBreeds()

            if !breedsData.isEmpty {
                breeds = prepareBreedsToPresent(breedsData: breedsData)
                catBreedList.reloadData()
            }
        }
    }
    
    func retrieveCatBreeds() -> [CatBreed] {
        if let file = Bundle.main.url(forResource: "CatBreeds", withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let breedsData = try JSONDecoder().decode(Array<CatBreed>.self,
                                                          from: data)
                return breedsData
            } catch {
                print("Não consegui obter dados")
                return []
            }
        } else {
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
        switch coatName {
        case "Short":
            return "shortIcon"
        case "Long":
            return "longIcon"
        case "Hairless/Furry down":
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

