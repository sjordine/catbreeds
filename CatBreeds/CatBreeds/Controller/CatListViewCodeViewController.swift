//
//  CatListViewCodeViewController.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 07/05/24.
//

import UIKit

class CatListViewCodeViewController: UIViewController {
    
    let catListViewModel = CatListViewModel()
    
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
            await catListViewModel.fetchBreeds()
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

}
