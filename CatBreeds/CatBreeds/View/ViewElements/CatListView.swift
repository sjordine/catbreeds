//
//  CatListView.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 07/05/24.
//

import UIKit

class CatListView: UIView {
    
    var breeds: [CatBreedInfo] = []
    
    private lazy var breedList: UITableView = {
        return UITableView()
    }()
    
    init() {
        // Chamamos um método da UIView para inicialização
        super.init(frame: .zero)
        
        setupView()
    }
    
    // O método a seguir é obrigatório na classe UIView
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup() {
        
    }
    
    public func update(breeds:[CatBreedInfo]) {
        self.breeds = breeds
        self.breedList.reloadData()
    }
    
    
    private func setupView() {
        setupSubviews()
        setupLayout()
    }
    
    private func setupSubviews() {
        breedList.translatesAutoresizingMaskIntoConstraints = false
        breedList.dataSource = self
        breedList.register(UINib(nibName: "CatBreedTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CatBreedCell")
        self.addSubview(breedList)
        
    }
    
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            breedList.topAnchor.constraint(equalTo: self.topAnchor),
            breedList.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            breedList.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            breedList.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

extension CatListView: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatBreedCell",
                                                 for: indexPath)
        
        let currentBreed = breeds[indexPath.row]
        
        if let cell = cell as? CatBreedTableViewCell {
            
            cell.breedName.text = currentBreed.breed
            cell.countryName.text = currentBreed.countryName
            cell.countryFlag.text = currentBreed.flag
            cell.coatIcon.image = UIImage(named: currentBreed.coatIcon)
            cell.layoutIfNeeded()
        }
        
        return cell
    }
    
}


