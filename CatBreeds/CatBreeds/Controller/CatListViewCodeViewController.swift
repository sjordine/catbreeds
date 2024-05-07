//
//  CatListViewCodeViewController.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 07/05/24.
//

import UIKit

class CatListViewCodeViewController: UIViewController {
    
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
        
    }
    

}
