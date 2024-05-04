//
//  ViewController.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import UIKit

class CatListViewController: UIViewController {
    
    @IBOutlet weak var catBreedList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            if let file = Bundle.main.url(forResource: "CatBreeds", withExtension: "json") {
                var breeds = []
                
                let data = try Data(contentsOf: file)
                breeds = try JSONDecoder().decode(Array<CatBreed>.self,
                                                      from: data)
                
                
                if !breeds.isEmpty {
                    print(breeds)
                }
            }
        }
    }
    
    
}

