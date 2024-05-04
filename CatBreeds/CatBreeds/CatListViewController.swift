//
//  ViewController.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import UIKit

class CatListViewController: UIViewController {
    
    @IBOutlet weak var catBreedList: UITableView!
    
    var breeds:[CatBreed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catBreedList.dataSource = self
        Task {
            if let file = Bundle.main.url(forResource: "CatBreeds", withExtension: "json") {

                let data = try Data(contentsOf: file)
                breeds = try JSONDecoder().decode(Array<CatBreed>.self,
                                                      from: data)

                if !breeds.isEmpty {
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
            
            switch currentBreed.coat {
            case "Short":
                cell.coatIcon.image = UIImage(named: "shortIcon")
            case "Long":
                cell.coatIcon.image = UIImage(named: "longIcon")
            default:
                cell.coatIcon.image = nil
            }
            
            
        }
        
        return cell
    }
    
    
}

