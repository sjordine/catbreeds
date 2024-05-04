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
            // Do any additional setup after loading the view.
            if let url = URL(string: "https://catfact.ninja/breeds") {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                } catch {
                    print(error)
                }
            }
        }
    }


}

