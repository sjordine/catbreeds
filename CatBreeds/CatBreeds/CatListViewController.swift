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
            if let file = Bundle.main.url(forResource: "CatBreeds", withExtension: "json") {

                let data = try Data(contentsOf: file)
                let breedsData = try JSONDecoder().decode(Array<CatBreed>.self,
                                                      from: data)

                if !breedsData.isEmpty {
                    breeds = breedsData.map { catBreed in
                        var iconName = ""
                        switch catBreed.coat {
                        case "Short":
                            iconName = "shortIcon"
                        case "Long":
                            iconName = "longIcon"
                        case "Hairless/Furry down":
                            iconName = "hairlessIcon"
                        default:
                            iconName = ""
                        }
                        return CatBreedInfo(breed: catBreed.breed,
                                            coatIcon: iconName)
                    }
                    catBreedList.reloadData()
                }
            }
        }
    }
    
}

extension CatListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatBreedCell", for: indexPath)
        
        let currentBreed = breeds[indexPath.row]
        
        if let cell = cell as? CatBreedTableViewCell {
            
            cell.breedName.text = currentBreed.breed
            
            cell.coatIcon.image = UIImage(named: currentBreed.coatIcon)
            
            
        }
        
        return cell
    }
    
    
}

