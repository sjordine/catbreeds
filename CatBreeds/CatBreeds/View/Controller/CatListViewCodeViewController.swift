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
        
        setupBindings()
        
        // Do any additional setup after loading the view.
        
        catListView.setup()
        
        Task {
            await catListViewModel.fetchBreeds()
        }
        
    }
    
    func setupBindings() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(breedListUpdated(_:)),
                                       name: Notification.Name("UpdateBreedList"),
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(breedListError(_:)),
                                       name: Notification.Name("FetchError"),
                                       object: nil)
    }
    
    @objc
    private func breedListUpdated(_ notification: NSNotification) {
        if let breeds = notification.userInfo?["breeds"] as? [CatBreedInfo] {
            catListView.update(breeds: breeds)
        }
    }
    
    @objc
    private func breedListError(_ notification: NSNotification) {
        if let _ = notification.userInfo?["error"] as? Error {
            showErrorAlert()
        }
    }
    
    func showErrorAlert() {
        Task {
            await MainActor.run {
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
    }
    
}
